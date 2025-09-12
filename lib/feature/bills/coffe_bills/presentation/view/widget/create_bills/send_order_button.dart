import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../../core/widget/widget/custom_flush.dart';
import '../../../../param/create_bills_coffee_param.dart';
import '../../../manager/coffee_bills/coffee_bills_cubit.dart';
import '../../../manager/coffee_bills/order_cubit.dart';

class SendOrderButton extends StatelessWidget {
  const SendOrderButton({
    super.key,
    required this.formKey,
    required this.selectedBillId,
    required this.tableNumberController,
    required this.takeAway,
  });

  final GlobalKey<FormState> formKey;
  final int? selectedBillId;
  final TextEditingController tableNumberController;
  final bool takeAway;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (!formKey.currentState!.validate()) return;
          if (selectedBillId == null) {
            showRedFlush(context, LangKeys.nameRequired.tr());
            return;
          }

          final orders = context.read<OrdersCubit>().state;
          final products = orders.map((order) {
            return Products(
              productType: "product",
              productId: order.product.id ?? 0,
              quantity: order.quantity,
              notes: order.notes,
            );
          }).toList();

          final param = CreateBillsPCoffeeParam(
            product: products,
            billId: selectedBillId ?? 0,
            tableNumber: int.tryParse(tableNumberController.text.trim()) ?? 1,
            takeAway: takeAway,
          );

          context.read<CoffeeBillsCubit>().createBillsCoffeeCubit(param);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 4,
        ),
        child: const Text(
          "إرسال الطلب",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

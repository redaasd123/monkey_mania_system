import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/widget/widget/custom_build_header_sheet_.dart';
import 'package:monkey_app/core/widget/widget/custom_button.dart';
import 'package:monkey_app/core/widget/widget/custom_text_field.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
import 'package:monkey_app/feature/bills/presentation/manager/apply_discount_cubit/apply_discount_cubit.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/apply_discount_param.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/bills_view_body_item.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/close_bills_param.dart';

import '../../manager/close_bills_cubit/close_bills_cubit.dart';

class BillsListView extends StatelessWidget {
  const BillsListView({super.key, required this.bills});

  final List<BillsEntity> bills;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      itemCount: bills.length,
      itemBuilder: (context, index) {
        final reversedIndex = bills.length - 1 - index;
        final model = bills[reversedIndex];
        return GestureDetector(
          onTap: () {
            GoRouter.of(context)
                .push(AppRouter.kShowDetailBills,extra: model);
          },
          child: BillsViewBodyItem(
            closeOnPressed: () {
              final cubit = BlocProvider.of<CloseBillsCubit>(context);
              final visaCtrl = TextEditingController();
              final cashCtrl = TextEditingController();
              final instCtrl = TextEditingController();
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustombuildHeader(colorScheme, 'Pay', Colors.grey),
                        CustomTextField(
                          label: 'visa',
                          hint: 'Enter Value',
                          controller: visaCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        CustomTextField(
                          label: 'Vodafone Cash',
                          hint: 'Enter Value',
                          controller: cashCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        CustomTextField(
                          label: 'Insta Pay',
                          hint: 'Enter Value',
                          controller: instCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: "Apply",
                          onPressed: () {
                            cubit.closeBills(
                              CloseBillsParam(
                                id: model.id,
                                visa: double.tryParse(visaCtrl.text) ?? 0,
                                cash: double.tryParse(cashCtrl.text) ?? 0,
                                instaPay: double.tryParse(instCtrl.text) ?? 0,
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            ApplyDiscountonPressed: () {
              final ctrl = TextEditingController();
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustombuildHeader(colorScheme, 'Discount', Colors.grey),
                        CustomTextField(
                          label: 'Enter Discount Code',
                          hint: 'Enter Discount Code',
                          controller: ctrl,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: 'Appl',
                          onPressed: () {
                            final cubit = BlocProvider.of<ApplyDiscountCubit>(
                              context,
                            );
                            cubit.applyDiscount(
                              ApplyDiscountParams(
                                id: model.id!,
                                discount: ctrl.text,
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            bills: bills[reversedIndex],
          ),
        );
      },
    );
  }
}

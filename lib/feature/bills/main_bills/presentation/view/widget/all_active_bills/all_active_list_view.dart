import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/bills_view_body_item.dart';

import '../../../../../../../core/utils/app_router.dart';
import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../../core/widget/widget/custom_text_field.dart';
import '../../../../domain/entity/Bills_entity.dart';
import '../../../../domain/use_case/param/close_bills_param.dart';
import '../../../../domain/use_case/param/update_calculations_param.dart';
import '../../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../../manager/close_bills_cubit/close_bills_cubit.dart';
import '../../../manager/fetch_bills_cubit/bills_cubit.dart';
import '../actions_bills_bottom_sheet.dart';
import '../apply_discount_param.dart';
import '../show_calculations_bottom_sheet.dart';

class AllActiveListView extends StatefulWidget {
  const AllActiveListView({super.key, required this.bills});

  final List<BillsEntity> bills;

  @override
  State<AllActiveListView> createState() => _AllActiveListViewState();
}

class _AllActiveListViewState extends State<AllActiveListView> {
  final visaCtrl = TextEditingController();
  final cashCtrl = TextEditingController();
  final instCtrl = TextEditingController();

  @override
  void dispose() {
    visaCtrl.dispose();
    cashCtrl.dispose();
    instCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          BlocProvider.of<BillsCubit>(context).onRefreshActiveBills(),
      child: ListView.builder(
        itemCount: widget.bills.length,
        itemBuilder: (context, index) {
          final colorScheme = Theme.of(context).colorScheme;
          final reverseIndex = widget.bills.length - 1 - index;
          final model = widget.bills[reverseIndex];
          return GestureDetector(
            onTap: () {
              GoRouter.of(
                context,
              ).push(AppRouter.kShowDetailBills, extra: model.id);
            },
            child: BillsViewBodyItem(
              onUpdateCalculation: () async {
                final data = await showCalculationsBottomSheet(context);
                if (data != null) {
                  context.read<BillsCubit>().updateCalculation(
                    UpdateCalculationsParam(
                      id: model.id,
                      timePrice: data.timePrice,
                      visa: data.visa,
                      cash: data.cash,
                      instapay: data.instapay,
                    ),
                  );
                }
              },
              bills: model,
              onClose: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return PaymentBottomSheet(
                      totalPrice: model.totalPrice ?? 0,
                      colorScheme: colorScheme,
                      onSave: (visa, cash, instapay) {
                        context.read<CloseBillsCubit>().closeBills(
                          CloseBillsParam(
                            id: model.id,
                            visa: visa,
                            cash: cash,
                            instaPay: instapay,
                          ),
                        );
                      },
                    );
                  },
                );
              },
              onDiscount: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return DiscountBottomSheet(
                      colorScheme: colorScheme,
                      onSave: (discount) {
                        context.read<ApplyDiscountCubit>().applyDiscount(
                          ApplyDiscountParams(
                            id: model.id,
                            discount: discount,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

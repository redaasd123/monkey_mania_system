import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';

import '../../../../../../../core/utils/app_router.dart';
import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../../core/widget/widget/custom_build_header_sheet_.dart';
import '../../../../../../../core/widget/widget/custom_button.dart';
import '../../../../../../../core/widget/widget/custom_text_field.dart';
import '../../../../domain/entity/Bills_entity.dart';
import '../../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../../manager/close_bills_cubit/close_bills_cubit.dart';
import '../../../manager/get_one_bills_cubit.dart';
import '../apply_discount_param.dart';
import '../param/close_bills_param.dart';
import 'active_bills_view_item.dart';

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
    return ListView.builder(
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
          child: ActiveBillsViewItem(
            closeOnPressed: () async {
              BlocProvider.of<CloseBillsCubit>(context);
              await BlocProvider.of<GetOneBillsCubit>(
                context,
              ).getOneBills(model.id);

              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setModalState) {
                      visaCtrl.addListener(() => setModalState(() {}));
                      cashCtrl.addListener(() => setModalState(() {}));
                      instCtrl.addListener(() => setModalState(() {}));

                      return Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                        ),
                        child: SingleChildScrollView(
                          child: BlocBuilder<GetOneBillsCubit, GetOneBillsState>(
                            builder: (context, state) {
                              if (state is GetOneBillsSuccessState) {
                                final totalPrice = state.bills.totalPrice ?? 0;

                                final visa =
                                    double.tryParse(visaCtrl.text) ?? 0;
                                final cash =
                                    double.tryParse(cashCtrl.text) ?? 0;
                                final instaPay =
                                    double.tryParse(instCtrl.text) ?? 0;
                                final sum = visa + cash + instaPay;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustombuildHeader(
                                      Theme.of(context).colorScheme,
                                      LangKeys.payment.tr(),
                                      Colors.grey,
                                    ),
                                    Text(
                                      '${LangKeys.totalPrice.tr()}: ${totalPrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextField(
                                      label: LangKeys.visa.tr(),
                                      hint: LangKeys.enterValue.tr(),
                                      controller: visaCtrl,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      label: LangKeys.cash.tr(),
                                      hint: LangKeys.enterValue.tr(),
                                      controller: cashCtrl,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      label: LangKeys.instapay.tr(),
                                      hint: LangKeys.enterValue.tr(),
                                      controller: instCtrl,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      '${LangKeys.totalPrice.tr()}: ${sum.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: sum == totalPrice
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    CustomButton(
                                      text: LangKeys.save.tr(),
                                      onPressed: () {
                                        if ((totalPrice - sum).abs() < 0.01) {
                                          BlocProvider.of<CloseBillsCubit>(
                                            context,
                                          ).closeBills(
                                            CloseBillsParam(
                                              id: model.id,
                                              visa: visa,
                                              cash: cash,
                                              instaPay: instaPay,
                                            ),
                                          );
                                          Navigator.pop(context);
                                        } else {
                                          showRedFlush(
                                            context,
                                            'The sum must equal total price',
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                );
                              } else if (state is GetOneBillsFailureState) {
                                return Text(state.errMessage);
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ).whenComplete(() {
                visaCtrl.clear();
                cashCtrl.clear();
                instCtrl.clear();
              });
            },
            ApplyDiscountonPressed: () {
              final ctrl = TextEditingController();
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustombuildHeader(
                          colorScheme,
                          LangKeys.discountType.tr(),
                          Colors.grey,
                        ),
                        CustomTextField(
                          label: LangKeys.discountType.tr(),
                          hint: LangKeys.discountType.tr(),
                          controller: ctrl,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: LangKeys.save.tr(),
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
            bills: widget.bills[reverseIndex],
          ),
        );
      },
    );
  }
}

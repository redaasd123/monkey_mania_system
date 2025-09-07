import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/widget/widget/custom_build_header_sheet_.dart';
import 'package:monkey_app/core/widget/widget/custom_button.dart';
import 'package:monkey_app/core/widget/widget/custom_text_field.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/close_bills_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/widget/widget/custom_flush.dart';
import '../../../domain/entity/Bills_entity.dart';
import '../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../manager/close_bills_cubit/close_bills_cubit.dart';
import '../../manager/get_one_bills_cubit.dart';
import 'apply_discount_param.dart';
import 'bills_view_body_item.dart';

class BillsListView extends StatefulWidget {
  const BillsListView({super.key, required this.bills});

  final List<BillsEntity> bills;

  @override
  State<BillsListView> createState() => _BillsListViewState();
}

class _BillsListViewState extends State<BillsListView> {
  final visaCtrl = TextEditingController();
  final cashCtrl = TextEditingController();
  final instCtrl = TextEditingController();

  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    final cubit = BlocProvider.of<BillsCubit>(context);
    final state = cubit.state;
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= 0.6 * maxScroll && state.hasMore && !state.isLoading) {
      cubit.fetchBills(FetchBillsParam(page: state.currentPage));
    }
  }

  @override
  void dispose() {
    visaCtrl.dispose();
    cashCtrl.dispose();
    instCtrl.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillsCubit, BillsState>(
      builder: (context, state) {
        final bills = state.bills;
        return RefreshIndicator(
          onRefresh: () => BlocProvider.of<BillsCubit>(context).onRefresh(),
          child: ListView.builder(
            controller: scrollController,
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final colorScheme = Theme.of(context).colorScheme;
              final model = bills[index];
              return GestureDetector(
                onTap: () {
                  GoRouter.of(
                    context,
                  ).push(AppRouter.kShowDetailBills, extra: model.id);
                },
                child: BillsViewBodyItem(
                  closeOnPressed: () async {
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
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    16,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustombuildHeader(
                                      Theme.of(context).colorScheme,
                                      LangKeys.payment.tr(),
                                      Colors.grey,
                                    ),
                                    Text(
                                      '${LangKeys.totalPrice.tr()}: ${model.totalPrice?.toStringAsFixed(2) ?? "0.00"}',
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

                                    // المجموع
                                    Builder(
                                      builder: (context) {
                                        final visa =
                                            double.tryParse(visaCtrl.text) ?? 0;
                                        final cash =
                                            double.tryParse(cashCtrl.text) ?? 0;
                                        final instaPay =
                                            double.tryParse(instCtrl.text) ?? 0;
                                        final sum = visa + cash + instaPay;
                                        final totalPrice =
                                            model.totalPrice ?? 0;

                                        return Text(
                                          '${LangKeys.totalPrice.tr()}: ${sum.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: sum == totalPrice
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        );
                                      },
                                    ),

                                    const SizedBox(height: 20),

                                    CustomButton(
                                      text: LangKeys.save.tr(),
                                      onPressed: () {
                                        final visa =
                                            double.tryParse(visaCtrl.text) ?? 0;
                                        final cash =
                                            double.tryParse(cashCtrl.text) ?? 0;
                                        final instaPay =
                                            double.tryParse(instCtrl.text) ?? 0;
                                        final sum = visa + cash + instaPay;
                                        final totalPrice =
                                            model.totalPrice ?? 0;

                                        if ((totalPrice - sum).abs() < 0.01) {
                                          context
                                              .read<CloseBillsCubit>()
                                              .closeBills(
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
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 16,
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
                                  final cubit =
                                      BlocProvider.of<ApplyDiscountCubit>(
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
                  bills: model,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

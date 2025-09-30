import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/widget/widget/custom_text_field.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/update_calculations_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/show_calculations_bottom_sheet.dart';


import '../../../domain/entity/Bills_entity.dart';
import '../../../domain/use_case/param/close_bills_param.dart';
import '../../../domain/use_case/param/fetch_bills_param.dart';
import '../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../manager/close_bills_cubit/close_bills_cubit.dart';
import 'actions_bills_bottom_sheet.dart';
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
    super.initState();
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

  /// 🔹 Helper: احسب المجموع الحالي من كل الحقول
  double get currentSum {
    final visa = double.tryParse(visaCtrl.text) ?? 0;
    final cash = double.tryParse(cashCtrl.text) ?? 0;
    final instaPay = double.tryParse(instCtrl.text) ?? 0;
    return visa + cash + instaPay;
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
      },
    );
  }
}


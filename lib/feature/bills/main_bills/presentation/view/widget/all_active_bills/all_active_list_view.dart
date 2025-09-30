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
                  final cubit = context
                      .read<BillsCubit>()
                      .updateCalculation(
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
              onClose: () async {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
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
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  colorScheme.primary,
                                  colorScheme.onPrimary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Handle أعلى البوتوم شيت
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // عنوان
                                    Text(
                                      LangKeys.payment.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Divider(color: Colors.grey[300], thickness: 1.2),
                                    const SizedBox(height: 12),

                                    // السعر الكلي
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LangKeys.totalPrice.tr(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.tealAccent,
                                          ),
                                        ),
                                        Text(
                                          '${(double.tryParse(model.totalPrice.toString()) ?? 0).toStringAsFixed(2)} ج.م',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.tealAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    // حقول الدفع
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

                                    // المجموع الحالي
                                    Builder(
                                      builder: (context) {
                                        final visa = double.tryParse(visaCtrl.text) ?? 0;
                                        final cash = double.tryParse(cashCtrl.text) ?? 0;
                                        final instaPay = double.tryParse(instCtrl.text) ?? 0;
                                        final sum = visa + cash + instaPay;
                                        final totalPrice = model.totalPrice ?? 0;

                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Text(
                                              '${sum.toStringAsFixed(2)} ج.م',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: sum == totalPrice ? Colors.green : Colors.red,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),

                                    // زر الحفظ
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colorScheme.primary,
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 6,
                                      ),
                                      onPressed: () {
                                        final visa = double.tryParse(visaCtrl.text) ?? 0;
                                        final cash = double.tryParse(cashCtrl.text) ?? 0;
                                        final instaPay = double.tryParse(instCtrl.text) ?? 0;
                                        final sum = visa + cash + instaPay;
                                        final totalPrice = model.totalPrice ?? 0;

                                        if ((totalPrice - sum).abs() < 0.01) {
                                          context.read<CloseBillsCubit>().closeBills(
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
                                      child:  Text(
                                          LangKeys.save.tr(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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

              onDiscount: () {
                final ctrl = TextEditingController();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent, // للزوايا الدائرية
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple.shade300,
                              Colors.deepPurple.shade50,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Handle أعلى البوتوم شيت
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // العنوان
                                Text(
                                  LangKeys.discountType.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Divider(color: Colors.grey[300], thickness: 1.2),
                                const SizedBox(height: 12),

                                // حقل الخصم
                                CustomTextField(
                                  label: LangKeys.discountType.tr(),
                                  hint: LangKeys.discountType.tr(),
                                  controller: ctrl,
                                  keyboardType: TextInputType.name,
                                ),
                                const SizedBox(height: 20),

                                // زر الحفظ
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 6,
                                  ),
                                  onPressed: () {
                                    final cubit = BlocProvider.of<ApplyDiscountCubit>(context);
                                    cubit.applyDiscount(
                                      ApplyDiscountParams(
                                        id: model.id!,
                                        discount: ctrl.text,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child:  Text(
                                    LangKeys.save.tr(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).whenComplete(() => ctrl.clear());
              },
              bills: widget.bills[reverseIndex],
            ),
          );
        },
      ),
    );
  }
}

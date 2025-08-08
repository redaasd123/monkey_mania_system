import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/utils/styles.dart';

class ShowDetailBills extends StatelessWidget {
  const ShowDetailBills({super.key, required this.billsEntity});

  final BillsEntity billsEntity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(LangKeys.Bills, style: Styles.textStyle20.copyWith(color: colorScheme.onPrimary)),
        backgroundColor: colorScheme.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// عنوان الفاتورة
              Text(
                LangKeys.children.tr(),
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 12),

              if (billsEntity.children != null && billsEntity.children!.isNotEmpty)
                ...billsEntity.children!.map(
                      (child) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${LangKeys.name.tr()}: ${child.name ?? LangKeys.notFound.tr()}',
                                  style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          if (child.phoneNumbers != null && child.phoneNumbers!.isNotEmpty)
                            ...child.phoneNumbers!.map(
                                  (phone) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  children: [
                                    const Icon(Icons.phone_android, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        phone.phoneNumber ?? LangKeys.notFound.tr(),
                                        style: Styles.textStyle14.copyWith(color: colorScheme.onSurface),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        phone.relationship ?? LangKeys.notFound.tr(),
                                        style: Styles.textStyle14.copyWith(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            Text(
                              LangKeys.notFound.tr(),
                              style: Styles.textStyle14,
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Text(LangKeys.notFound.tr(), style: Styles.textStyle14),

              const SizedBox(height: 24),

              /// 💳 بيانات الدفع
              _buildBillRow(context, LangKeys.cash.tr(), billsEntity.cash),
              _buildBillRow(context, LangKeys.visa.tr(), billsEntity.visa),
              _buildBillRow(context, LangKeys.instapay.tr(), billsEntity.instapay),

              const SizedBox(height: 16),

              /// 💵 أسعار
              _buildBillRow(context, LangKeys.totalPrice.tr(), billsEntity.totalPrice?.toString()),
              _buildBillRow(context, LangKeys.productsPrice.tr(), billsEntity.productsPrice),
              _buildBillRow(context, LangKeys.timePrice.tr(), billsEntity.timePrice?.toString()),
              _buildBillRow(context, LangKeys.spentTime.tr(), billsEntity.spentTime?.toString()),

              const SizedBox(height: 16),

              /// 💸 خصومات
              _buildBillRow(context, LangKeys.discountValue.tr(), billsEntity.discountValue),
              _buildBillRow(context, LangKeys.discountType.tr(), billsEntity.discountType),

              const SizedBox(height: 16),

              /// 🏢 تفاصيل الفاتورة
              _buildBillRow(context, LangKeys.branch.tr(), billsEntity.branch),
              _buildBillRow(context, LangKeys.isActive.tr(), billsEntity.isActive?.toString()),
              _buildBillRow(context, LangKeys.isSubscription.tr(), billsEntity.isSubscription?.toString()),
              _buildBillRow(context, LangKeys.moneyUnbalance.tr(), billsEntity.moneyUnbalance?.toString()),

              const SizedBox(height: 16),

              /// ⏱️ وقت الإنشاء والإنهاء
              _buildBillRow(context, LangKeys.created.tr(), billsEntity.created?.toString()),
              _buildBillRow(context, LangKeys.finished.tr(), billsEntity.finished?.toString()),

              const SizedBox(height: 16),

              /// 👤 من أنشأ ومن أنهى
              _buildBillRow(context, LangKeys.createdBy.tr(), billsEntity.createdBy),
              _buildBillRow(context, LangKeys.finishedBy.tr(), billsEntity.finishedBy),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// صف بيانات الطفل (رقم وعلاقة)
  Widget _buildPhoneRow(BuildContext context, String? phone, String? relation) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${LangKeys.phoneNumber.tr()}: $phone',
                style: Styles.textStyle14.copyWith(color: colorScheme.onSurface),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${LangKeys.relationShip.tr()}: $relation',
              style: Styles.textStyle14.copyWith(color: colorScheme.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }

  /// صف بيانات الفاتورة
  Widget _buildBillRow(BuildContext context, String label, String? value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? LangKeys.notFound.tr(),
              textAlign: TextAlign.right,
              style: Styles.textStyle14.copyWith(color: colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

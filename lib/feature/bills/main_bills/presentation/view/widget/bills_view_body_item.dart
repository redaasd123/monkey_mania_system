import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/utils/styles.dart';

import '../../../domain/entity/Bills_entity.dart';

class BillsViewBodyItem extends StatelessWidget {
  const BillsViewBodyItem({
    super.key,
    required this.bills,
    required this.ApplyDiscountonPressed,
    required this.closeOnPressed,
  });
  final void Function() closeOnPressed;
  final void Function() ApplyDiscountonPressed;
  final BillsEntity bills;


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfo(
                  context: context,
                  icon: Icons.person,
                  label: LangKeys.name.tr(),
                  text: bills.children?[0].name ?? LangKeys.notFound.tr(),
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfo(
                  context: context,
                  icon: Icons.phone,
                  label: LangKeys.phoneNumber.tr(),
                  text:
                      bills.children?[0].phoneNumbers
                          ?.map((e) => e.phoneNumber)
                          .join(',') ??
                      LangKeys.notFound.tr(),

                  style: Styles.textStyle16.copyWith(
                    fontStyle: FontStyle.italic,
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfo(
                  context: context,
                  icon: Icons.timelapse_outlined,
                  label: LangKeys.spentTime.tr(),
                  text: bills.spentTime?.toString() ?? LangKeys.notFound.tr(),
                  style: Styles.textStyle16.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfo(
                  context: context,
                  icon: Icons.monetization_on_outlined,
                  label: LangKeys.totalPrice.tr(),
                  text: bills.totalPrice.toString() ?? LangKeys.notFound,
                  style: Styles.textStyle16.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfo(
                  context: context,
                  icon: Icons.child_care,
                  label: LangKeys.childrenCount.tr(),
                  text:
                      bills.childrenCount?.toString() ?? LangKeys.notFound.tr(),
                  style: Styles.textStyle16.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: ApplyDiscountonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: Text(
                        LangKeys.applyDiscount.tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: closeOnPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: const Text(
                        'إغلاق الفاتورة',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),

    );
  }

  Widget _buildInfo({
    required IconData icon,
    required String label,
    required dynamic text,
    required TextStyle style,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Styles.textStyle14.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.primary.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: style,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

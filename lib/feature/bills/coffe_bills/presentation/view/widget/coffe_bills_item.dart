import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../domain/entity/bills_coffee_entity.dart';

class CoffeeBillsItem extends StatelessWidget {
  const CoffeeBillsItem({
    super.key,
    required this.onTap,
    required this.billsCoffeeEntity,
  });

  final BillsCoffeeEntity billsCoffeeEntity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // --- top rows ---
            Row(
              children: [
                Expanded(
                  child: _buildInfo(
                    context: context,
                    icon: Icons.attach_money,
                    label: LangKeys.totalPrice.tr(),
                    text: billsCoffeeEntity.totalPrice.toString(),
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  child: _buildInfo(
                    context: context,
                    icon: Icons.table_bar,
                    label: LangKeys.tableNumber.tr(),
                    text: billsCoffeeEntity.tableNumber.toString(),
                    style: Styles.textStyle14.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: colorScheme.outlineVariant.withOpacity(0.4)),
            const SizedBox(height: 10),

            // --- second row ---
            Row(
              children: [
                Expanded(
                  child: _buildInfo(
                    context: context,
                    icon: Icons.receipt_long,
                    label: LangKeys.billsNumber.tr(),
                    text: billsCoffeeEntity.billNumber.toString(),
                    style: Styles.textStyle14.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  child: _buildInfo(
                    context: context,
                    icon: Icons.local_cafe,
                    label: LangKeys.takeAway.tr(),
                    text: billsCoffeeEntity.takeAway.toString(),
                    style: Styles.textStyle14.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Align(
              alignment: Alignment.center,
              child:  InkWell(
                onTap: onTap,
                child: FaIcon(
                  FontAwesomeIcons.eye,
                  size: 26,
                  color: colorScheme.primary,
                ),
              ),
            ),
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
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Styles.textStyle12.copyWith(
                  color: colorScheme.primary.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                text.toString(),
                style: style,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/utils/styles.dart';

class BillsViewBodyItem extends StatelessWidget {
  const BillsViewBodyItem({super.key, required this.bills});

  final BillsEntity bills;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo(
              context: context,
              icon: Icons.person,
              label: 'Name',
              text: bills.name ?? 'لا يوجد اسم',
              style: Styles.textStyle20.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfo(
              context: context,
              icon: Icons.phone,
              label: 'Phone Number',
              text: bills.phoneNumber ?? 'لا يوجد رقم',
              style: Styles.textStyle16.copyWith(
                fontStyle: FontStyle.italic,
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16),
            _buildInfo(
              context: context,
              icon: Icons.timelapse_outlined,
              label: 'Spent Time',
              text: bills.SpentTime?.toString() ?? 'غير متاح',
              style: Styles.textStyle16.copyWith(
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16),
            _buildInfo(
              context: context,
              icon: Icons.monetization_on_outlined,
              label: 'Total Price',
              text: bills.TotalPrice.toString() ?? 'غير متاح',
              style: Styles.textStyle16.copyWith(
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16),
            _buildInfo(
              context: context,
              icon: Icons.child_care,
              label: 'Children Count',
              text: bills.ChildrenCount?.toString() ?? 'غير متاح',
              style: Styles.textStyle16.copyWith(
                color: colorScheme.onSurface.withOpacity(0.8),
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
    required String text,
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../domain/entity/bills_coffee_entity.dart';

class CoffeeBillsItem extends StatelessWidget {
  const CoffeeBillsItem({super.key, required this.billsCoffeeEntity,
  });
  final BillsCoffeeEntity billsCoffeeEntity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Card(
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

                const SizedBox(height: 16),
                _buildInfo(
                  context: context,
                  icon: Icons.price_change,
                  label: LangKeys.totalPrice.tr(),
                  text: billsCoffeeEntity.totalPrice.toString(),
                  style: Styles.textStyle16.copyWith(
                    fontStyle: FontStyle.italic,
                    color: colorScheme.onSurface.withOpacity(0.8),

                  ),
                ),
                const SizedBox(height: 16),
                _buildInfo(
                  context: context,
                  icon: Icons.numbers,
                  label: LangKeys.tableNumber.tr(),
                  text: billsCoffeeEntity.tableNumber.toString(),
                  //bills.spentTime?.toString() ?? LangKeys.notFound.tr(),
                  style: Styles.textStyle16.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfo(
                  context: context,
                  icon: Icons.numbers,
                  label: LangKeys.billsNumber.tr(),
                  text: billsCoffeeEntity.billNumber.toString(),
                  //bills.totalPrice.toString() ?? LangKeys.notFound,
                  style: Styles.textStyle16.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfo(
                  context: context,
                  icon: Icons.flight_takeoff_outlined,
                  label: LangKeys.takeAway.tr(),
                  text: billsCoffeeEntity.takeAway.toString(),
                  style: Styles.textStyle16.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
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

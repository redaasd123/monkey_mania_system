import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../domain/entity/bills_coffee_entity.dart';

class CoffeeBillsItem extends StatelessWidget {
  const CoffeeBillsItem({
    super.key,
    required this.billsCoffeeEntity,
  });

  final BillsCoffeeEntity billsCoffeeEntity;

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


//import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../../core/utils/langs_key.dart';
// import '../../../../../../core/utils/styles.dart';
// import '../../../domain/entity/bills_coffee_entity.dart';
//
// class CoffeeBillsItem extends StatelessWidget {
//   const CoffeeBillsItem({
//     super.key,
//     required this.billsCoffeeEntity,
//   });
//
//   final BillsCoffeeEntity billsCoffeeEntity;
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       elevation: 5,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           gradient: LinearGradient(
//             colors: [
//               colorScheme.surface.withOpacity(0.95),
//               colorScheme.primary.withOpacity(0.05),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInfo(
//                     context: context,
//                     icon: Icons.attach_money,
//                     label: LangKeys.totalPrice.tr(),
//                     text: billsCoffeeEntity.totalPrice.toString(),
//                     valueStyle: Styles.textStyle16.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: colorScheme.onSurface,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: _buildInfo(
//                     context: context,
//                     icon: Icons.table_bar,
//                     label: LangKeys.tableNumber.tr(),
//                     text: billsCoffeeEntity.tableNumber.toString(),
//                     valueStyle: Styles.textStyle16.copyWith(
//                       color: colorScheme.onSurface,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Divider(color: colorScheme.outlineVariant.withOpacity(0.4)),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInfo(
//                     context: context,
//                     icon: Icons.receipt_long,
//                     label: LangKeys.billsNumber.tr(),
//                     text: billsCoffeeEntity.billNumber.toString(),
//                     valueStyle: Styles.textStyle16.copyWith(
//                       color: colorScheme.onSurface,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: _buildInfo(
//                     context: context,
//                     icon: Icons.local_cafe,
//                     label: LangKeys.takeAway.tr(),
//                     text: billsCoffeeEntity.takeAway.toString(),
//                     valueStyle: Styles.textStyle16.copyWith(
//                       color: colorScheme.onSurface,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfo({
//     required IconData icon,
//     required String label,
//     required dynamic text,
//     required TextStyle valueStyle,
//     required BuildContext context,
//   }) {
//     final colorScheme = Theme.of(context).colorScheme;
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             color: colorScheme.primary.withOpacity(0.15),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, size: 20, color: colorScheme.primary),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: Styles.textStyle12.copyWith(
//                   color: colorScheme.primary.withOpacity(0.8),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 3),
//               Text(
//                 text.toString(),
//                 style: valueStyle,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
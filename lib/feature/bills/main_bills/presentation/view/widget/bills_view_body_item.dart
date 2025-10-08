import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/langs_key.dart';
import '../../../domain/entity/Bills_entity.dart';

class BillsViewBodyItem extends StatelessWidget {
  const BillsViewBodyItem({
    super.key,
    required this.bills,
    required this.onDiscount,
    required this.onClose,
    required this.onUpdateCalculation,
  });

  final VoidCallback onUpdateCalculation;
  final BillsEntity bills;
  final VoidCallback onDiscount;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 صورة الطفل
            CircleAvatar(
              radius: 24,
              backgroundColor: colorScheme.primary.withOpacity(0.15),
              child: Icon(Icons.person, color: colorScheme.primary, size: 26),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم الطفل
                  Text(
                    (bills.children != null && bills.children!.isNotEmpty)
                        ? bills.children!.first.name ?? LangKeys.notFound.tr()
                        : LangKeys.notFound.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 3),

                  // أرقام التليفونات
                  Text(
                    (bills.children != null && bills.children!.isNotEmpty)
                        ? bills.children!.first.phoneNumbers
                                  ?.map((e) => e.phoneNumber)
                                  .join(', ') ??
                              LangKeys.notFound.tr()
                        : LangKeys.notFound.tr(),
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 6),

                  // سعر + عدد أطفال
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "${bills.totalPrice ?? 0} ${LangKeys.totalPrice.tr()}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          "${bills.childrenCount ?? 0} ${LangKeys.childrenCount.tr()}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 50,
              child:
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildActionButton(
                    icon: Icons.local_offer_outlined,
                    color: colorScheme.primary,
                    onTap: onDiscount,
                    tooltip: LangKeys.applyDiscount.tr(),
                  ),
                  const SizedBox(height: 6),

                  const SizedBox(height: 6),
                  bills.isActive == true
                      ? _buildActionButton(
                          icon: Icons.close,
                          color: Colors.red,
                          onTap: onClose,
                          tooltip: LangKeys.cansel.tr(),
                        )
                      : _buildActionButton(
                          icon: Icons.calculate_outlined,
                          color: Colors.orange,
                          onTap: onUpdateCalculation,
                          tooltip: "تحديث الحساب",
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}

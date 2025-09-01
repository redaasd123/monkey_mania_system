import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import '../../../../../core/utils/styles.dart';

class ChildrenViewBodyItem extends StatelessWidget {
  const ChildrenViewBodyItem({super.key, required this.childrenEntity});

  final ChildrenEntity childrenEntity;

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
              icon: Icons.school,
              label: LangKeys.name.tr(),
              text: childrenEntity.name ?? 'لا يوجد اسم',
              style: Styles.textStyle20.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
              context: context,
            ),
            const SizedBox(height: 16),
            _buildInfo(
              icon: Icons.location_on_outlined,
              label: LangKeys.address.tr(),
              text: childrenEntity.address ?? 'لا يوجد عنوان',
              style: Styles.textStyle16.copyWith(
                color: colorScheme.onSurface.withOpacity(0.9),
              ),
              context: context,
            ),
            const SizedBox(height: 16),
            _buildInfo(
              icon: Icons.phone,
              label: LangKeys.phoneNumber.tr(),
              text: childrenEntity.childPhoneNumbersSet?.isNotEmpty == true
                  ? childrenEntity.childPhoneNumbersSet!.first.phoneNumber ??
                  'لا يوجد رقم'
                  : 'لا يوجد رقم',
              style: Styles.textStyle16.copyWith(
                fontStyle: FontStyle.italic,
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
              context: context,
            ),
            const SizedBox(height: 20),

            // 👇 Row الأزرار (تفاصيل + تعديل)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    GoRouter.of(context).push(
                      AppRouter.kShowDetailChildren,
                      extra: childrenEntity,
                    );
                  },

                  icon: const Icon(Icons.edit),
                  label: Text("تعديل", style: Styles.textStyle14),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    side: BorderSide(color: colorScheme.primary, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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

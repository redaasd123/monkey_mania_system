import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import '../../../../../core/utils/styles.dart';

class ChildrenViewBodyItem extends StatelessWidget {
  const ChildrenViewBodyItem({super.key, required this.childrenModel});

  final ChildrenEntity childrenModel;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: colorScheme.surface, // اللون حسب الثيم
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfo(
                  icon: Icons.school,
                  label: LangKeys.name.tr(),
                  text: childrenModel.name ?? 'لا يوجد اسم',
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary, // اللون حسب الثيم
                  ),
                  context: context,
                ),
                const SizedBox(height: 16),
                _buildInfo(
                  icon: Icons.location_on_outlined,
                  label: LangKeys.address.tr(),
                  text: childrenModel.address ?? 'لا يوجد عنوان',
                  style: Styles.textStyle16.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.9), // اللون حسب الثيم
                  ),
                  context: context,
                ),
                const SizedBox(height: 16),
                _buildInfo(
                  icon: Icons.phone,
                  label: LangKeys.phoneNumber.tr(),
                  text: childrenModel.childPhoneNumbersSet?.isNotEmpty == true
                      ? childrenModel.childPhoneNumbersSet!.first.phoneNumber ?? 'لا يوجد رقم'
                      : 'لا يوجد رقم',
                  style: Styles.textStyle16.copyWith(
                    fontStyle: FontStyle.italic,
                    color: colorScheme.onSurface.withOpacity(0.7), // اللون حسب الثيم
                  ),
                  context: context,
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: isArabic ? 180 : 180,
          right: isArabic ? 340 : 20,
          child: GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kShowDetailChildren, extra: childrenModel);
            },
            child: Icon(Icons.edit, color: colorScheme.primary), // اللون حسب الثيم
          ),
        ),
      ],
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
        Icon(icon, size: 22, color: colorScheme.primary), // اللون حسب الثيم
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Styles.textStyle14.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.primary.withOpacity(0.8), // اللون حسب الثيم
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

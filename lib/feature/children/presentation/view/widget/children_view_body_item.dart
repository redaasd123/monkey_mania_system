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
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // <<<<< هنا شيلنا الـ color
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // نفس radius الكارت
          gradient: LinearGradient(
            colors: [
              colorScheme.surface,
              colorScheme.primary.withOpacity(0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// الاسم
              Row(
                children: [
                  Icon(Icons.person, size: 18, color: colorScheme.primary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      childrenEntity.name ?? "لا يوجد اسم",
                      style: Styles.textStyle14.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

// العنوان
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: colorScheme.secondary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      childrenEntity.address ?? "لا يوجد عنوان",
                      style: Styles.textStyle12.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),

// رقم الهاتف
              Row(
                children: [
                  Icon(Icons.phone, size: 16, color: colorScheme.tertiary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      childrenEntity.childPhoneNumbersSet?.isNotEmpty == true
                          ? childrenEntity.childPhoneNumbersSet!.first.phoneNumber ?? "لا يوجد رقم"
                          : "لا يوجد رقم",
                      style: Styles.textStyle12.copyWith(
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

// أيقونة التفاصيل جوّه الكارت
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRouter.kShowDetailChildren,
                      extra: childrenEntity,
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.visibility, size: 16, color: colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(
                        "عرض",
                        style: Styles.textStyle12.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}




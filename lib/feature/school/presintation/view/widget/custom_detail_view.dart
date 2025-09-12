import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import '../../../../../core/utils/styles.dart';
import '../../../domain/entity/school_entity.dart';

class CustomDetailSchoolCard extends StatelessWidget {
  const CustomDetailSchoolCard({super.key, required this.schoolModel});

  final SchoolEntity schoolModel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.surfaceVariant.withOpacity(0.95),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
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
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الاسم
              Row(
                children: [
                  Icon(Icons.school_rounded,
                      size: 20, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      schoolModel.name,
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // العنوان
              Row(
                children: [
                  Icon(Icons.location_on_rounded,
                      size: 18, color: colorScheme.secondary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      schoolModel.address,
                      style: Styles.textStyle14.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.85),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // الملاحظات
              Row(
                children: [
                  Icon(Icons.notes_rounded,
                      size: 18, color: colorScheme.tertiary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      schoolModel.notes?.isNotEmpty == true
                          ? schoolModel.notes!
                          : LangKeys.notFoundNote.tr(),
                      style: Styles.textStyle12.copyWith(
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onSurface.withOpacity(0.65),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

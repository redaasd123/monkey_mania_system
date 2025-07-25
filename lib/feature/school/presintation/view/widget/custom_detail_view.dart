import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../school/data/model/school_model.dart';
import '../../../domain/entity/school_entity.dart';

class CustomDetailSchoolCard extends StatelessWidget {
  const CustomDetailSchoolCard({super.key, required this.schoolModel});

  final SchoolEntity schoolModel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 6,
      shadowColor: colorScheme.primary.withOpacity(0.2),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: colorScheme.surfaceVariant.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo(
              icon: Icons.school_rounded,
              label: LangKeys.name.tr(),
              text: schoolModel.name,
              style: Styles.textStyle20.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
              context: context,
            ),
            const SizedBox(height: 20),
            _buildInfo(
              icon: Icons.location_on_rounded,
              label: LangKeys.address.tr(),
              text: schoolModel.address,
              style: Styles.textStyle16.copyWith(
                color: colorScheme.onSurface.withOpacity(0.85),
              ),
              context: context,
            ),
            const SizedBox(height: 20),
            _buildInfo(
              icon: Icons.notes_rounded,
              label: LangKeys.notes.tr(),
              text: schoolModel.notes?.isNotEmpty == true
                  ? schoolModel.notes!
                  : LangKeys.notFoundNote.tr(),
              style: Styles.textStyle16.copyWith(
                fontStyle: FontStyle.italic,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              context: context,
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
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 24, color: colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Styles.textStyle14.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 6),
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

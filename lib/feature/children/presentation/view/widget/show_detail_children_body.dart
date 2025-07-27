import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/utils/styles.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';

import '../../../../../core/utils/formate_age.dart';
import '../../../../../core/utils/formate_date.dart';

class ShowDetailChildrenBody extends StatelessWidget {
  const ShowDetailChildrenBody({super.key, required this.childrenEntity});

  final ChildrenEntity childrenEntity;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            backgroundColor: colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                bottom: 16,
                left: 16,
                right: 16,
              ),
              title: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  childrenEntity.name ?? '',
                  style: Styles.textStyle20.copyWith(
                    color: colorScheme.onPrimary,
                    shadows: const [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                _buildLabeledBox(
                  context,
                  LangKeys.name.tr(),
                  childrenEntity.name,
                ),
                _buildLabeledBox(
                  context,
                  LangKeys.dateOfBirth.tr(),
                  childrenEntity.birthDate,
                ),
                _buildLabeledBox(
                  context,
                  LangKeys.age.tr(),
                  childrenEntity.birthDate != null
                      ? formatAge(DateTime.parse(childrenEntity.birthDate!))
                      : LangKeys.notFound.tr(),
                ),

                _buildLabeledBox(
                  context,
                  LangKeys.address.tr(),
                  childrenEntity.address,
                ),
                _buildLabeledBox(
                  context,
                  LangKeys.school.tr(),
                  childrenEntity.school?.toString(),
                ),
                _buildLabeledBox(
                  context,
                  LangKeys.notes.tr(),
                  childrenEntity.notes,
                ),
                _buildLabeledBox(
                  context,
                  LangKeys.active.tr(),
                  childrenEntity.isActive.toString(),
                ),
                _buildLabeledBox(
                  context,
                  LangKeys.specialNeeds.tr(),
                  childrenEntity.specialNeeds.toString(),
                ),
                _buildLabeledBox(
                  context,
                  LangKeys.createdBy.tr(),
                  childrenEntity.createdBy,
                ),
                _buildLabeledBox(
                  context,
                  LangKeys.createdAt.tr(),
                  childrenEntity.created != null
                      ? formatDateOnly(childrenEntity.created!)
                      : LangKeys.notFound.tr(),
                ),
                _buildLabeledBox(
                  context,
                  LangKeys.lastUpdate.tr(),
                  childrenEntity.created != null
                      ? formatDateOnly(childrenEntity.created!)
                      : LangKeys.notFound.tr(),
                ),
                _buildSectionTitle(context, LangKeys.phoneNumber.tr()),
                if (childrenEntity.childPhoneNumbersSet != null)
                  ...childrenEntity.childPhoneNumbersSet!.map(
                    (phone) => _buildPhoneBox(
                      context,
                      phone.phoneNumber,
                      phone.relationship,
                    ),
                  ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledBox(BuildContext context, String title, String? value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          title: Text(
            title,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          subtitle: Text(
            value ?? LangKeys.notFound.tr(),
            style: Styles.textStyle16.copyWith(color: colorScheme.onSurface),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Styles.textStyle16.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildPhoneBox(BuildContext context, String? phone, String? relation) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                phone ?? LangKeys.notFound.tr(),
                textAlign: TextAlign.right,
                style: Styles.textStyle14.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              relation ?? LangKeys.notFound.tr(),
              style: Styles.textStyle14.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

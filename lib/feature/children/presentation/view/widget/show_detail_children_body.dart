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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          childrenEntity.name ?? LangKeys.notFound.tr(),
          style: Styles.textStyle20.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            _buildSmallCard(
              context,
              icon: Icons.person,
              title: LangKeys.name.tr(),
              value: childrenEntity.name,
            ),
            _buildSmallCard(
              context,
              icon: Icons.cake,
              title: LangKeys.dateOfBirth.tr(),
              value: childrenEntity.birthDate,
            ),
            _buildSmallCard(
              context,
              icon: Icons.timeline,
              title: LangKeys.age.tr(),
              value: childrenEntity.birthDate != null
                  ? formatAge(DateTime.parse(childrenEntity.birthDate!))
                  : LangKeys.notFound.tr(),
            ),
            _buildSmallCard(
              context,
              icon: Icons.home,
              title: LangKeys.address.tr(),
              value: childrenEntity.address,
            ),
            _buildSmallCard(
              context,
              icon: Icons.school,
              title: LangKeys.school.tr(),
              value: childrenEntity.school?.toString(),
            ),
            _buildSmallCard(
              context,
              icon: Icons.note,
              title: LangKeys.notes.tr(),
              value: childrenEntity.notes,
            ),
            _buildSmallCard(
              context,
              icon: Icons.check_circle,
              title: LangKeys.active.tr(),
              value: childrenEntity.isActive.toString(),
            ),
            _buildSmallCard(
              context,
              icon: Icons.accessibility,
              title: LangKeys.specialNeeds.tr(),
              value: childrenEntity.specialNeeds.toString(),
            ),
            _buildSmallCard(
              context,
              icon: Icons.person_outline,
              title: LangKeys.createdBy.tr(),
              value: childrenEntity.createdBy,
            ),
            _buildSmallCard(
              context,
              icon: Icons.date_range,
              title: LangKeys.createdAt.tr(),
              value: childrenEntity.created != null
                  ? formatDateOnly(childrenEntity.created!)
                  : LangKeys.notFound.tr(),
            ),
            _buildSmallCard(
              context,
              icon: Icons.update,
              title: LangKeys.lastUpdate.tr(),
              value: childrenEntity.created != null
                  ? formatDateOnly(childrenEntity.created!)
                  : LangKeys.notFound.tr(),
            ),

            const SizedBox(height: 16),

            Text(
              LangKeys.phoneNumber.tr(),
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 8),

            if (childrenEntity.childPhoneNumbersSet != null)
              ...childrenEntity.childPhoneNumbersSet!.map(
                    (phone) => _buildPhoneCard(
                  context,
                  phone.phoneNumber,
                  phone.relationship,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String? value,
      }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: colorScheme.primary.withOpacity(0.1),
          child: Icon(icon, color: colorScheme.primary, size: 20),
        ),
        title: Text(
          title,
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        subtitle: Text(
          value ?? LangKeys.notFound.tr(),
          style: Styles.textStyle14.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneCard(
      BuildContext context,
      String? phone,
      String? relation,
      ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: colorScheme.secondary.withOpacity(0.1),
          child: Icon(Icons.phone, color: colorScheme.secondary, size: 20),
        ),
        title: Text(
          phone ?? LangKeys.notFound.tr(),
          style: Styles.textStyle14.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            relation ?? LangKeys.notFound.tr(),
            style: Styles.textStyle14.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

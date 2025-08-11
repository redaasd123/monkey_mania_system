import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/param/update_school_param/update_school_param.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/school/presintation/manager/put_cubit/put_cubit.dart';
import 'package:monkey_app/feature/school/presintation/manager/school_cubit/school_cubit.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/custom_detail_view.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/show_add_bottom_sheet.dart';

import '../../../domain/entity/school_entity.dart';

class SchoolListView extends StatelessWidget {
  const SchoolListView({super.key, required this.school});

  final List<SchoolEntity> school;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<SchoolCubit>(context).fetchSchool(),
      child: ListView.builder(
        itemCount: school.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          // 👇 قلبنا الفهرس بحيث 0 ← أحدث عنصر
          final model = school[school.length - 1 - index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GestureDetector(
              onTap: () async {
                final data = await schoolShowAddSchoolSheet(
                  context,
                  text: LangKeys.edit.tr(),
                  model: model,
                );

                final updateCubit = context.read<UpdateSchoolCubit>();

                if (data != null) {
                  updateCubit.updateSchool(
                    UpdateSchoolParam(
                      id: model.id,
                      name: data.name,
                      address: data.address,
                      notes: data.notes?.trim().isEmpty ?? true
                          ? null
                          : data.notes,
                    ),
                  );
                }
              },

              child: CustomDetailSchoolCard(schoolModel: model),
            ),
          );
        },
      ),
    );
  }
}

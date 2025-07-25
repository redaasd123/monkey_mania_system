import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/school/presintation/view/widget/show_add_bottom_sheet.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../manager/post_cubit/post_cubit.dart';

class ReseveDataSchoolActionButton extends StatelessWidget {
  const ReseveDataSchoolActionButton({
    super.key,
    required this.context,
    required this.colorScheme,
  });

  final BuildContext context;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: colorScheme.primary, // لون الخلفية
      foregroundColor: colorScheme.onPrimary, // لون الأيقونة على الخلفية
      child: Icon(Icons.add),
      onPressed: () async {
        final postCubit = context.read<PostCubit>();
        final data = await schoolShowAddSchoolSheet(
          context,
          text: LangKeys.save.tr(),
        );
        if (data != null) {
          postCubit.postSchool(
            name: data['name']!,
            address: data['address']!,
            notes: (data['notes']?.trim().isEmpty ?? true)
                ? null
                : data['notes'],
          );
        }
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:monkey_app/core/param/create_school_param/create_school_param.dart';

import '../../../domain/entity/school_entity.dart';
import 'add_school_bottom_sheet.dart';

Future<CreateSchoolParam?> schoolShowAddSchoolSheet(
  BuildContext ctx, {
  required String text,
  SchoolEntity? model,
}) {
  return showModalBottomSheet<CreateSchoolParam>(
    context: ctx,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddSchoolBottomSheet(text: text, model: model),
  );
}

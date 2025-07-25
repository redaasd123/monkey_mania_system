import 'package:flutter/material.dart';
import 'package:monkey_app/feature/school/data/model/school_model.dart';
import '../../../domain/entity/school_entity.dart';
import 'add_school_bottom_sheet.dart';

Future<Map<String, String?>?> schoolShowAddSchoolSheet(
    BuildContext ctx, {
      required String text,
      SchoolEntity? model, // هنا بقت named & optional
    }) {
  return showModalBottomSheet<Map<String, String?>>(
    context: ctx,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddSchoolBottomSheet(text: text, model: model),
  );
}
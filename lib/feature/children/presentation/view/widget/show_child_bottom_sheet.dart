import 'package:flutter/material.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/add_child_bottom_sheet.dart';

import '../../../../../core/param/create_children_params/create_children_params.dart';

Future<CreateChildrenParam?>? showAddChildBottomSheet(
  BuildContext ctx,
  String title, {
  ChildrenEntity? model,
}) {
  return showModalBottomSheet<CreateChildrenParam>(
    context: ctx,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: AddChildBottomSheet(title: title, childrenEntity: model),
    ),
  );
}

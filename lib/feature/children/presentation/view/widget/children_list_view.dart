import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';
import 'package:monkey_app/feature/children/domain/entity/children/children_entity.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/children_cubit.dart';
import 'package:monkey_app/feature/children/presentation/manager/cubit/update_children_cubit.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/children_view_body_item.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/show_child_bottom_sheet.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/param/update_children_param/update_children_param.dart';

class ChildrenListView extends StatelessWidget {
  const ChildrenListView({super.key, required this.children});

  final List<ChildrenEntity> children;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()=>BlocProvider.of<ChildrenCubit>(context).fetchChildren(),
      child: ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) {
          final reversedIndex = children.length - 1 - index;
          return GestureDetector(
            onTap: () async {
              final model = children[reversedIndex];
              final data = await showAddChildBottomSheet(context,LangKeys.edit.tr(), model: model);
              if (data != null) {
                final cubit =BlocProvider.of<UpdateChildrenCubit>(context);
                print("🔍 name value: ${data.name} (${data.name.runtimeType})");
                cubit.updateChildren(
                    UpdateChildrenParam(
                      notes: data.notes,
                        school: data.school,
                        phoneNumber: data.phones,
                        name: data.name,
                        address: data.address,
                        id: model.id!.toInt(),
                        birthDate: data.birthDate));
              }
            },
            child: ChildrenViewBodyItem(childrenEntity: children[reversedIndex]),
          );
        },
      ),
    );
  }
}

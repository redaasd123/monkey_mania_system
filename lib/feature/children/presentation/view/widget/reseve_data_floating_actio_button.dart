import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/children/presentation/view/widget/show_child_bottom_sheet.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../manager/cubit/children_cubit.dart';
import '../../manager/cubit/create_child_cubit.dart';

FloatingActionButton ReseveDataChildrenActionButton(BuildContext context) {
  return FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () async {
      final createCubit = BlocProvider.of<CreateChildCubit>(context);
      final childrenCubit = BlocProvider.of<ChildrenCubit>(context);
      final data = await showAddChildBottomSheet(
        context,
        LangKeys.addChild.tr(),
      );
      if (data != null) {
        debugPrint("✅ DATA FROM SHEET: $data");
        await createCubit.createChildren(data).then((value) async {
          await childrenCubit.fetchChildren();
        });
      }
    },
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/view/material_bottom_sheet.dart';

Future<CreateExpenseParam?> showMaterialExpenseBottomSheet(
    BuildContext context, String title
    ,{MaterialExpenseItemEntity? item}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (_) =>  MaterialExpenseBottomSheet(title: title,item: item,),

  );
}




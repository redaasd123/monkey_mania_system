import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';
import 'general_expense_bottom_sheet.dart';
Future<CreateExpenseParam?> showGeneralExpenseBottomSheet(
    BuildContext context, String title
,{GeneralExpenseItemEntity? item}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (_) =>  GeneralExpenseBottomSheet(title: title,item:item),

  );
}




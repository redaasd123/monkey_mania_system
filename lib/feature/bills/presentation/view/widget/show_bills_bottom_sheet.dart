import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/bills_bottom_sheet.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/create_bills_param.dart';

Future<CreateBillsParam?> showBillsBottomSheet(BuildContext context, String title) {
  return showModalBottomSheet<CreateBillsParam?>(
    isScrollControlled: true,
    context: context,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BillsBottomSheet(title: title),
    ),
  );
}

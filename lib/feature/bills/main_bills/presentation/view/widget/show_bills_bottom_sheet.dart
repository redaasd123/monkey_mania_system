import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/use_case/param/create_bills_param.dart';
import 'bills_bottom_sheet.dart';

Future<CreateBillsParam?> showBillsBottomSheet(
    BuildContext context,
    String title,
    ) {
  return showModalBottomSheet<CreateBillsParam?>(
    isScrollControlled: true,
    context: context,
    builder: (_) =>  BillsBottomSheet(title: title),

  );
}


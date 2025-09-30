import 'package:flutter/material.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/update_calculations_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/calculations_bottom_sheet.dart';

Future<UpdateCalculationsParam?> showCalculationsBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (_) => CalculationsBottomSheet(),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../manager/branch_cubit.dart';
import 'branch_bottom_sheet_body.dart';

Future<void> showBranchBottomSheet(
  BuildContext context, {
  required void Function(FetchBillsParam) onSelected,
}) async {
  BlocProvider.of<BranchCubit>(context).fetchBranch();

  final data = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BranchBottomSheetBody();
    },
  );

  if (data != null) {
    onSelected(data);
  }
}

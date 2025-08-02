import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/branch/presentation/manager/branch_cubit.dart';
import 'feature/home/presentation/view/widget/view/bottom_sheet/branch_bottom_sheet_body.dart';

class BranchService {
  void showBranchList(BuildContext context) {
    final cubit = BlocProvider.of<BranchCubit>(context);
    cubit.fetchBranch();
    final data = showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return BranchBottomSheetBody();
      },
    );
  }

  void showDateBicker(BuildContext context) async {
    final DateTime? dateTime;
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      dateTime = date;
      print(dateTime);
    }
  }
}

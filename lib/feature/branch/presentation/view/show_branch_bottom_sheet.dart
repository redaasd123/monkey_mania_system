import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/widget/custom_show_loder.dart';
import '../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../manager/branch_cubit.dart';
import 'branch_bottom_sheet_body.dart';

Future<void> showBranchBottomSheet(
  BuildContext context, {
  required void Function(RequestParameters) onSelected,
}) async {
  final cubit = BlocProvider.of<BranchCubit>(context);

  if (cubit.state.status != BranchStatus.success) {
    await cubit.fetchBranches();
  }

  final data = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return const BranchBottomSheetBody();
    },
  );

  if (data != null) {
    onSelected(data);
  }
}

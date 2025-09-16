import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/login/presentaion/view/widget/select_branch_with_login.dart';
import '../../../../bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../../../../branch/presentation/manager/branch_cubit.dart';


Future<void> showSelectBranchWithLoginBottomSheet(
    BuildContext context, {
      required void Function(int) onSelected,
    }) async {
  BlocProvider.of<BranchCubit>(context).fetchBranch();

  final data = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SelectBranchWithLogin();
    },
  );

  if (data != null) {
    onSelected(data);
  }
}

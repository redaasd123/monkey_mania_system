import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/manager/material_expense_cubit.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/view/material_expense_list_view.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/widget/widget/custom_flush.dart';
import '../../../../bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../../../../branch/presentation/manager/branch_cubit.dart';

class MaterialExpenseViewBody extends StatelessWidget {
  const MaterialExpenseViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BranchCubit, BranchState>(
          listener: (context, state) {
            if (state is BranchSelectedState) {
              context.read<MaterialExpenseCubit>().fetchAllMaterialExpense(
                FetchBillsParam(branch: [state.branchId]),
              );
            }
          },
        ),

        BlocListener<MaterialExpenseCubit, MaterialExpenseState>(
          listener: (context, state) {
            if (state.status == MaterialExpenseStatus.createSuccess) {
              showGreenFlush(context, "Expense created successfully ✅");
            } else if (state.status == MaterialExpenseStatus.createFailure) {
              showRedFlush(context, state.errMessage ?? '');
            } else if (state.status == MaterialExpenseStatus.updateSuccess) {
              showGreenFlush(context, "Expense updated successfully ✅");
            } else if (state.status == MaterialExpenseStatus.updateFailure) {
              showRedFlush(context, state.errMessage ?? '');
            }
          },
        ),
      ],
      child: BlocBuilder<MaterialExpenseCubit, MaterialExpenseState>(
        builder: (context, state) {
          if (state.status == MaterialExpenseStatus.searchLoading) {
            return Stack(
              children: [
                MaterialExpenseListView(items: state.items ?? []),
                const Center(
                  child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                ),
                const LinearProgressIndicator(minHeight: 3),
              ],
            );
          }

          if (state.status == MaterialExpenseStatus.empty) {
            return const Center(
              child: Text('No Data', style: Styles.textStyle14),
            );
          }

          if (state.status == MaterialExpenseStatus.createLoading ||
              state.status == MaterialExpenseStatus.updateLoading) {
            return Stack(
              children: [
                MaterialExpenseListView(items: state.items ?? []),
                const Center(
                  child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                ),
              ],
            );
          } else if (state.status == MaterialExpenseStatus.success ||
              state.status == MaterialExpenseStatus.pagenationLoading ||
              state.status == MaterialExpenseStatus.createSuccess ||
              state.status == MaterialExpenseStatus.createFailure ||
              state.status == MaterialExpenseStatus.updateSuccess ||
              state.status == MaterialExpenseStatus.updateFailure) {
            return MaterialExpenseListView(items: state.items ?? []);
          } else if (state.status == MaterialExpenseStatus.failure) {
            return Center(child: Text(state.errMessage ?? 'reda'));
          } else {
            return const Center(
              child: SpinKitFadingCircle(color: Colors.blue, size: 60),
            );
          }
        },
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/branch/presentation/manager/branch_cubit.dart';
import 'package:monkey_app/feature/expense/general_expense/presentation/manager/general_expense_cubit.dart';

import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'general_expense_list_view.dart';

class GeneralExpenseViewBody extends StatelessWidget {
  const GeneralExpenseViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// لو الفرع اتغير، اعمل fetch للـ coffee bills
        BlocListener<BranchCubit, BranchState>(
          listener: (context, state) {
            if (state.status == BranchStatus.selected && state.selectedBranchId != null) {
              context.read<GeneralExpenseCubit>().fetchAllGeneralExpense(
                RequestParameters(branch: [state.selectedBranchId!]),
              );
            }

          },
        ),

        /// لو حصل عمليات تخص المصروفات (create / update)
        BlocListener<GeneralExpenseCubit, GeneralExpenseState>(
          listener: (context, state) {
            if (state.status == GeneralExpenseStatus.createSuccess) {
              showGreenFlush(context, LangKeys.ok.tr());
            } else if (state.status == GeneralExpenseStatus.createFailure) {
              showRedFlush(context, state.errMessage ?? '');
            } else if (state.status == GeneralExpenseStatus.updateSuccess) {
              showGreenFlush(context, LangKeys.ok.tr());
            } else if (state.status == GeneralExpenseStatus.updateFailure) {
              showRedFlush(context, state.errMessage ?? '');
            }
          },
        ),
      ],
      child: BlocBuilder<GeneralExpenseCubit, GeneralExpenseState>(
        builder: (context, state) {
          if (state.status == GeneralExpenseStatus.searchLoading) {
            return Stack(
              children: [
                GeneralExpenseListView(items: state.items ?? []),
                const Center(
                  child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                ),
                const LinearProgressIndicator(minHeight: 3),
              ],
            );
          }

          if (state.status == GeneralExpenseStatus.empty) {
            return Center(
              child: Text(LangKeys.notFound.tr(), style: Styles.textStyle14),
            );
          }

          if (state.status == GeneralExpenseStatus.createLoading ||
              state.status == GeneralExpenseStatus.updateLoading) {
            return Stack(
              children: [
                GeneralExpenseListView(items: state.items ?? []),
                const Center(
                  child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                ),
              ],
            );
          } else if (state.status == GeneralExpenseStatus.success ||
              state.status == GeneralExpenseStatus.pagenationLoading ||
              state.status == GeneralExpenseStatus.createSuccess ||
              state.status == GeneralExpenseStatus.createFailure ||
              state.status == GeneralExpenseStatus.updateSuccess ||
              state.status == GeneralExpenseStatus.updateFailure) {
            return GeneralExpenseListView(items: state.items ?? []);
          } else if (state.status == GeneralExpenseStatus.failure) {
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

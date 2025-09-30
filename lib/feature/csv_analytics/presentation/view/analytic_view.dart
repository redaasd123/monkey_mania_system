import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/my_app_drwer.dart';
import 'package:monkey_app/feature/csv_analytics/presentation/manager/anlytic_cubit.dart';
import 'package:monkey_app/feature/csv_analytics/presentation/view/widget/analytic_view_body.dart';

import '../../../../core/download_fiels/download_file.dart';
import '../../../../core/utils/poppup_menu_button.dart';
import '../../../branch/presentation/view/show_branch_bottom_sheet.dart';

class AnalyticView extends StatelessWidget {
  const AnalyticView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: MyAppDrawer(),
      body: AnalyticViewBody(),
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          CustomPopupMenu(
            onBranch: () {
              showBranchBottomSheet(
                context,
                onSelected: (param) {
                  final cubit = context.read<AnalyticCubit>();
                  final updatedFilters = cubit.state.filters.copyWith(
                    branch: param.branch,
                    startDate: param.startDate,
                    endDate: param.endDate,
                  );
                  cubit.setParam(updatedFilters);
                 // cubit.fetchBills(updatedFilters);
                },
              );
            },


          ),
        ],
      ),
    );
  }
}

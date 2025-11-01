import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/feature/branch/presentation/view/show_branch_bottom_sheet.dart';
import 'package:monkey_app/feature/home/presentation/manager/home_cubit.dart';
import 'package:monkey_app/feature/login/presentaion/view/widget/show_select_branch_with_login.dart';

import '../../../../../../core/utils/my_app_drwer.dart';
import '../../../../../../core/utils/poppup_menu_button.dart';
import '../../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../../../branch/presentation/manager/branch_cubit.dart';
import 'home_view_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: HomeListView(),
      appBar: AppBar(
        actions:[
          CustomPopupMenu(onBranch: (){
            showBranchBottomSheet(context, onSelected: (param){
              final cubit = context.read<HomeCubit>();
              cubit.fetchDashBoardData(param);
            });
          },)
        ],
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      backgroundColor: colorScheme.background,
      drawer: const MyAppDrawer(),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BranchCubit, BranchState>(
          listener: (context, state) {
            if (state.status == BranchStatus.selected && state.selectedBranchId != null) {
              final branchId = state.selectedBranchId!;
              context.read<HomeCubit>().fetchDashBoardData(
                RequestParameters(branch: [branchId]),
              );
            }
          },

        ),

        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) async {
            if (state.status == HomeStatus.initial) {
              var branch = AuthHelper.getBranch();
              if (branch == null) {
                showSelectBranchWithLoginBottomSheet(
                  context,
                  onSelected: (selectedBranch) {
                    Hive.box(kAuthBox).put(AuthKeys.branchId, selectedBranch);
                    BlocProvider.of<HomeCubit>(context).fetchDashBoardData(
                      RequestParameters(branch: [selectedBranch]),
                    );
                  },
                );
              }
            }
          },
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.success) {
            final data = state.data!;
            return HomeViewBodyItem(data: data);
          } else if (state.status == HomeStatus.failure) {
            return Center(child: Text(state.errMessage ?? 'error'));
          } else if (state.status == HomeStatus.loading) {
            return const Center(
              child: SpinKitFadingCircle(color: Colors.blue, size: 60),
            );
          } else {
            return Center(child: Text(state.errMessage ?? 'no thing'));
          }
        },
      ),
    );
  }
}

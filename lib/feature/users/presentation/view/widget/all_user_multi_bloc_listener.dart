import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/feature/users/presentation/view/widget/user_list_view.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/widget/widget/custom_flush.dart';
import '../../../../../core/widget/widget/custom_show_loder.dart';
import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../../branch/presentation/manager/branch_cubit.dart';
import '../../manager/user_cubit.dart';

class AllUserMultiBlocListener extends StatelessWidget {
  const AllUserMultiBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) async {
            switch (state.status) {
              case UserStatus.failure:
              case UserStatus.addFailure:
              case UserStatus.updateFailure:
                hideLoader(context);
                showRedFlush(context, state.errorMessage ?? 'Create failed');
                break;

              case UserStatus.addSuccess:
                hideLoader(context);
                showGreenFlush(context, LangKeys.createdSuccessfully.tr());
                break;
              case UserStatus.updateSuccess:
                hideLoader(context);
                showGreenFlush(context, LangKeys.updatedSuccessfully.tr());
                break;


              case UserStatus.addLoading:
                showLoader(context);
                break;

              default:
                break;
            }
          },
        ),
        BlocListener<BranchCubit, BranchState>(
          listener: (context, state) {
            if (state is BranchSelectedState) {
              context.read<UserCubit>().fetchUsers(
                RequestParameters(branch: [state.branchId]),
              );
            }
          },
        ),
      ],

      /// 🔹 Builder
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          switch (state.status) {
            // ---------------- Loading ----------------
            case UserStatus.searchLoading:
              return Stack(
                children: [
                  Center(
                    child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                  ),
                  LinearProgressIndicator(minHeight: 3),
                ],
              );

            case UserStatus.addLoading:
            case UserStatus.updateLoading:
            case UserStatus.loading:
              return Stack(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(minHeight: 3),
                  ),
                  UserListView(data: state.data ?? []),
                  Center(
                    child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                  ),
                ],
              );

            // ---------------- Success & Failure ----------------
            case UserStatus.success:
            case UserStatus.failure:
            case UserStatus.addFailure:
            case UserStatus.addSuccess:
            case UserStatus.updateFailure:
            case UserStatus.updateSuccess:
              return UserListView(data: state.data ?? []);

            // ---------------- Empty ----------------
            case UserStatus.empty:
              return  Center(child: Text(LangKeys.notFound.tr(),));

            // ---------------- Default ----------------
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

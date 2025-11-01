import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/home/presentation/manager/home_cubit.dart';
import 'package:monkey_app/feature/login/presentaion/manager/login_cubit/login_cubit.dart';
import 'package:monkey_app/feature/login/presentaion/view/widget/login_page_item.dart';
import 'package:monkey_app/feature/login/presentaion/view/widget/show_select_branch_with_login.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/widget/widget/custom_show_loder.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        hideLoader(context);

        switch (state.status) {
          case LoginStatus.loading:
            showLoader(context);
            break;

          case LoginStatus.success:
            final role = AuthHelper.getRole();
            if (role == 'owner' || role == 'admin') {
              showSelectBranchWithLoginBottomSheet(
                context,
                onSelected: (id) async {
                  Hive.box(kAuthBox).put(AuthKeys.branchId, id);
                  showGreenFlush(context, LangKeys.loginSuccess.tr());
                  await Future.delayed(const Duration(milliseconds: 1000));
                  if (context.mounted) {
                    GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
                  }
                },
              );
            } else {
              showGreenFlush(context, LangKeys.loginSuccess.tr());
              await Future.delayed(const Duration(milliseconds: 1000));
              if (context.mounted) {
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
              }
            }
            break;

          case LoginStatus.failure:
            showRedFlush(context, state.errMessage ?? "حدث خطأ غير متوقع");
            break;

          case LoginStatus.initial:
            break;
        }
      },
      child: const LoginPageItem(),
    );
  }
}

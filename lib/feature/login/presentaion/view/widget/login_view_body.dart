import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/utils/app_router.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/login/presentaion/manager/login_cubit/login_cubit.dart';
import 'package:monkey_app/feature/login/presentaion/view/widget/login_page_item.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/widget/widget/custom_show_loder.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context,state) async {
        hideLoader(context);
        if (state is LoginLoadingState) {
          showLoader(context);
        } else if (state is LoginSuccessState) {
          showGreenFlush(context, LangKeys.loginSuccess.tr());
          await Future.delayed(const Duration(milliseconds: 1000));
          if (context.mounted) {
            GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
          }
        } else if (state is LoginFailureState) {
          showRedFlush(
            context,
            state.errMessage,
          );
        }
      },
      child: const LoginPageItem(),
    );
  }
}

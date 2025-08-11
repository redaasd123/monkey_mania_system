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
      listener: (context, state) async {
        // أغلق أى حوار لو كان مفتوحًا
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
            LangKeys.loginFailure.tr(),
          ); // أو أي دالة بتظهر رسالة خطأ
        }
      },
      child: const LoginPageItem(),
    );
  }
}

// return BlocProvider(
//       create: (_) => getIt<LoginCubit>(),
//       child: BlocListener<LoginCubit, LoginState>(
//         listener: (context, state) {
//           if (state is LoginLoading) {
//             // إظهار لودينج
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (_) => const Center(child: CircularProgressIndicator()),
//             );
//           } else if (state is LoginSuccess) {
//             Navigator.of(context).pop(); // إغلاق اللودينج
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
//             );
//             // انتقل لصفحة تانية (لو عندك مثلا HomeView)
//             // GoRouter.of(context).pushReplacement('/school');
//           } else if (state is LoginFailure) {
//             Navigator.of(context).pop(); // إغلاق اللودينج
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.errMessage)),
//             );
//           }
//         },
//         child: const LoginViewBody(),
//       ),
//     );

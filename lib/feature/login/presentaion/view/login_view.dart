import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/login/presentaion/view/widget/login_view_body.dart';
import '../../../../core/utils/service_locator.dart';

import '../../../../core/widget/appbar.dart';
import '../manager/login_cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: Scaffold(
        body: AppBackgroundWrapper(
          child: LoginViewBody(),
        ),
      ),
    );
  }
}

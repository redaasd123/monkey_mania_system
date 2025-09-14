import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/home/presentation/manager/home_cubit.dart';
import 'package:monkey_app/feature/home/presentation/view/widget/view/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..fetchDashBoardData(),
      child: HomeViewBody(),
    );
  }
}

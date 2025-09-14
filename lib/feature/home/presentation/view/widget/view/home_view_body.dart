import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/feature/home/domain/entity/home_entity.dart';
import 'package:monkey_app/feature/home/presentation/manager/home_cubit.dart';

import '../../../../../../core/utils/my_app_drwer.dart';
import 'home_view_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    return Scaffold(
      body: HomeListView(),
      appBar: AppBar(
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        print("HomeState: ${state.status}");
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
    );
  }
}


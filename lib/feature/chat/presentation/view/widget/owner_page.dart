import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/feature/users/presentation/manager/user_cubit.dart';
import 'owner_list_view.dart';

class OwnerPage extends StatelessWidget {
  const OwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final users = state.data;
        if (state.status == UserStatus.success && users != null) {
          return SafeArea(
            child: Scaffold(
              body: Column(children: [OwnerListView(users: users)]),
            ),
          );
        } else if (state.status == UserStatus.failure) {
          return Text(state.errorMessage ?? '');
        } else {
          return Center(child: SpinKitFadingCircle(color: Colors.blue));
        }
      },
    );
  }
}



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/feature/users/presentation/manager/user_cubit.dart';

import '../../../../../core/utils/langs_key.dart';
import 'owner_list_view.dart';

class OwnerPage extends StatefulWidget {
  const OwnerPage({super.key});

  @override
  State<OwnerPage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final users = state.userDataForFireBase ?? [];
        Widget body;
        switch (state.status) {
          case UserStatus.loading:
          case UserStatus.searchLoading:
            body = Stack(
              children: [
                OwnerListViewBlocConsumer(users: users),
                const Align(
                  alignment: Alignment.topCenter,
                  child: LinearProgressIndicator(minHeight: 3),
                ),
                const Center(
                  child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                ),
              ],
            );
            break;

          case UserStatus.success:
            body = OwnerListViewBlocConsumer(users: users);
            break;
          case UserStatus.empty:
            body = Center(
              child: Text(
                LangKeys.notFound.tr(),
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
            break;

          case UserStatus.failure:
            body = Center(
              child: Text(
                state.errorMessage ?? LangKeys.notFound.tr(),
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
            break;

          default:
            body = OwnerListViewBlocConsumer(users: users);
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            title: state.isSearching
                ? TextField(
                    autofocus: true,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    cursorColor: colorScheme.onPrimary,
                    decoration: InputDecoration(
                      hintText: LangKeys.search.tr(),
                      hintStyle: TextStyle(
                        color: colorScheme.onPrimary.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      filled: true,
                      fillColor: colorScheme.primary,
                    ),
                    onChanged: (val) {
                      context.read<UserCubit>().searchUsers(val);
                    },
                  )
                : Text(
                    LangKeys.users.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
            actions: [
              IconButton(
                icon: Icon(state.isSearching ? Icons.close : Icons.search),
                onPressed: () {
                  context.read<UserCubit>().toggleSearch();
                },
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: body,
          ),
        );
      },
    );
  }
}

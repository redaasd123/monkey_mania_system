import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';
import 'package:monkey_app/feature/users/domain/repo/create_user_param.dart';
import 'package:monkey_app/feature/users/presentation/manager/user_cubit.dart';
import 'package:monkey_app/feature/users/presentation/view/widget/all_user_multi_bloc_listener.dart';
import 'package:monkey_app/feature/users/presentation/view/widget/show_user_bottom_sheet.dart';

import '../../../../core/utils/langs_key.dart';
import '../../../../core/utils/my_app_drwer.dart';
import '../../../../core/utils/poppup_menu_button.dart';
import '../../../branch/presentation/view/show_branch_bottom_sheet.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: const MyAppDrawer(),
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            final cubit = context.read<UserCubit>();
            return state.isSearching
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      filled: true,
                      fillColor: colorScheme.primary,
                    ),
                    onChanged: (val) {
                      cubit.searchUsers(val);
                    },
                  )
                : Text(
                    LangKeys.users.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
          },
        ),

        actions: [
          IconButton(
            icon: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Icon(state.isSearching ? Icons.close : Icons.search);
              },
            ),
            onPressed: () {
              setState(() {
                context.read<UserCubit>().toggleSearch();
              });
            },
          ),
          CustomPopupMenu(
            onBranch: () {
              showBranchBottomSheet(
                context,
                onSelected: (param) {
                  context.read<UserCubit>().fetchUsers(param);
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final data = await showUserBottomSheet(
            context,
            LangKeys.save.tr(),true,
          );
          final cubit = context.read<UserCubit>();
          if (data != null) {
            cubit.createUser(
              CreateUserParam(
                userName: data.userName,
                branch: data.branch,
                password: data.password,
                confirmPass: data.confirmPass,
                phoneNumber: data.phoneNumber,
                role: data.role,
                email: data.email,
              ),
            );
          }
        },
      ),
      body: AllUserMultiBlocListener(),
    );
  }
}

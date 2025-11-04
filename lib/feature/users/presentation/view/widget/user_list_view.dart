import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/users/domain/repo/update_user_param.dart';
import 'package:monkey_app/feature/users/presentation/view/widget/show_user_bottom_sheet.dart';
import 'package:monkey_app/feature/users/presentation/view/widget/user_view_item.dart';

import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../domain/entity/user_data_entity.dart';
import '../../manager/user_cubit.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key, required this.data});

  final List<UserDataEntity> data;

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _autoFetchMore();
    });
  }

  void _autoFetchMore() {
    if (!mounted) return;

    final cubit = BlocProvider.of<UserCubit>(context);
    final state = cubit.state;

    if (!scrollController.hasClients) return;

    if (scrollController.position.maxScrollExtent <= 0 &&
        state.hasMore &&
        !state.isLoading) {
      cubit.fetchUsers(RequestParameters(page: state.currentPage));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _autoFetchMore();
      });
    }
  }

  void scrollListener() {
    if (!mounted) return;
    final cubit = BlocProvider.of<UserCubit>(context);
    final state = cubit.state;

    if (!scrollController.hasClients) return;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= 0.6 * maxScroll && state.hasMore && !state.isLoading) {
      cubit.fetchUsers(RequestParameters(page: state.currentPage));
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final bills = state.data ?? [];
        return RefreshIndicator(
          onRefresh: () => BlocProvider.of<UserCubit>(context).onRefresh(),
          child: ListView.builder(
            controller: scrollController,
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final model = bills[index];
              return InkWell(
                onTap: () async {
                  final data = await showUserBottomSheet(
                    context,
                    LangKeys.edit.tr(),
                    false,
                    data: model,
                  );
                  if (data != null && mounted) {
                    final cubit = context.read<UserCubit>();
                    cubit.updateUser(
                      UpdateUserParam(
                        password: data.password,
                        confirmPass: data.confirmPass,
                        phoneNumber: data.phoneNumber,
                        userName: data.userName,
                        email: data.email,
                        branch: data.branch,
                        role: data.role,
                        id: model.id,
                      ),
                    );
                  }
                },
                child: UserViewItem(dataEntity: model),
              );
            },
          ),
        );
      },
    );
  }
}

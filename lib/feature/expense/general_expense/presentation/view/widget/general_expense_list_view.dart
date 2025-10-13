import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/feature/expense/general_expense/presentation/manager/general_expense_cubit.dart';
import 'package:monkey_app/feature/expense/general_expense/presentation/view/widget/show_general_expense_bottom_sheet.dart';

import '../../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../domain/entity/general_expense_item_entity.dart';
import '../../../domain/use_case/param/update_param.dart';
import 'general_expense_item.dart';

class GeneralExpenseListView extends StatefulWidget {
  final List<GeneralExpenseItemEntity> items;

  const GeneralExpenseListView({super.key, required this.items});

  @override
  State<GeneralExpenseListView> createState() => _GeneralExpenseListViewState();
}

class _GeneralExpenseListViewState extends State<GeneralExpenseListView> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    final cubit = BlocProvider.of<GeneralExpenseCubit>(context);
    final state = cubit.state;
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= 0.8 * maxScroll && state.hasMore && !state.isLoading) {
      cubit.fetchAllGeneralExpense(
        RequestParameters(page: state.currentPage, branch: ['all']),
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GeneralExpenseCubit>();
    final state = cubit.state;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients &&
          scrollController.position.maxScrollExtent == 0 &&
          state.hasMore &&
          !state.isLoading) {
        cubit.fetchAllGeneralExpense(
          RequestParameters(page: state.currentPage, branch: ['all']),
        );
      }
    });

    return ListView.builder(
      controller: scrollController,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            final data = await showGeneralExpenseBottomSheet(
              context,
              LangKeys.edit.tr(),
              item: widget.items[index],
            );
            if (data != null) {
              BlocProvider.of<GeneralExpenseCubit>(
                context,
              ).updateGeneralExpense(
                UpdateExpenseParam(
                  id: widget.items[index].id,
                  name: data.name!,
                  branchId: data.branchId!,
                  totalPrice: data.totalPrice!,
                  quantity: data.quantity!,
                ),
              );
            }
          },
          child: GeneralExpenseItem(item: widget.items[index]),
        );
      },
    );
  }
}

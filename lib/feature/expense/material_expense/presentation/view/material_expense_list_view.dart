import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/manager/material_expense_cubit.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/view/show_material_bottom_sheet.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../../../bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../../../general_expense/domain/use_case/param/update_param.dart';
import 'material_expense_item.dart';

class MaterialExpenseListView extends StatefulWidget {
  const MaterialExpenseListView({super.key, required this.items});

  final List<MaterialExpenseItemEntity> items;

  @override
  State<MaterialExpenseListView> createState() =>
      _MaterialExpenseListViewState();
}

class _MaterialExpenseListViewState extends State<MaterialExpenseListView> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    final cubit = BlocProvider.of<MaterialExpenseCubit>(context);
    final state = cubit.state;
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= 0.8 * maxScroll && state.hasMore && !state.isLoading) {
      cubit.fetchAllMaterialExpense(
        FetchBillsParam(page: state.currentPage, branch: ['all']),
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
    final cubit = context.read<MaterialExpenseCubit>();
    final state = cubit.state;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients &&
          scrollController.position.maxScrollExtent == 0 &&
          state.hasMore &&
          !state.isLoading) {
        cubit.fetchAllMaterialExpense(FetchBillsParam(
            branch: ['all'],
            page: state.currentPage));
      }
    });

    return ListView.builder(
      controller: scrollController,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            final data = await showMaterialExpenseBottomSheet(
              context,
              LangKeys.edit.tr(),
              item: widget.items[index],
            );
            if (data != null) {
              BlocProvider.of<MaterialExpenseCubit>(
                context,
              ).updateMaterialExpense(
                UpdateExpenseParam(
                  materialId: data.materialId,
                  id: widget.items[index].id,
                  branchId: data.branchId,
                  totalPrice: data.totalPrice,
                  quantity: data.quantity,
                ),
              );
            }
          },
          child: MaterialExpenseItem(item: widget.items[index]),
        );
      },
    );
  }
}

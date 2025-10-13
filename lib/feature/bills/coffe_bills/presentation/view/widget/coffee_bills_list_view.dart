import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffe_bills_item.dart';

import '../../../../../../core/utils/app_router.dart';
import '../../../../main_bills/domain/use_case/param/fetch_bills_param.dart';

class CoffeeBillsListView extends StatefulWidget {
  const CoffeeBillsListView({super.key, required this.bills});

  final List<BillsCoffeeEntity> bills;

  @override
  State<CoffeeBillsListView> createState() => _CoffeeBillsListViewState();
}

class _CoffeeBillsListViewState extends State<CoffeeBillsListView> {
  final visaCtrl = TextEditingController();
  final cashCtrl = TextEditingController();
  final instCtrl = TextEditingController();

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    final cubit = BlocProvider.of<CoffeeBillsCubit>(context);
    final state = cubit.state;
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= 0.8 * maxScroll && state.hasMore && !state.isLoading) {
      cubit.fetchBillsCoffee(
        RequestParameters(page: state.currentPage,branch: ['all']),
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    visaCtrl.dispose();
    cashCtrl.dispose();
    instCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBillsCubit, BillsCoffeeState>(
      builder: (context, state) {
        final bills = state.bills;
        return RefreshIndicator(
          onRefresh: () =>
              BlocProvider.of<CoffeeBillsCubit>(context).onRefresh(),
          child: ListView.builder(
            controller: scrollController,
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final modal = bills[index];
              return GestureDetector(
                onTap: () {
                  GoRouter.of(
                    context,
                  ).push(AppRouter.kShowDetailCoffeeBills, extra: modal.id);
                },
                child: CoffeeBillsItem(billsCoffeeEntity: modal),
              );
            },
          ),
        );
      },
    );
  }
}

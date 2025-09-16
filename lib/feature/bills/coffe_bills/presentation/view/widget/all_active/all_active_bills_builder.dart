import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';

import '../../../manager/coffee_bills/coffee_bills_cubit.dart';
import 'all_active_bills_coffee_list_view.dart';

class ActiveCoffeeListViewBuilder extends StatelessWidget {
  const ActiveCoffeeListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoffeeBillsCubit, BillsCoffeeState>(
      listener: (context, state) {
        // ---------------- Failure ----------------
        if (state.status == CoffeeBillsStatus.activeFailure) {
          showRedFlush(context, state.errorMessage ?? "حدث خطأ");
        }
        // ---------------- Success ----------------

        // ---------------- Loading ----------------
      },
      builder: (context, state) {
        switch (state.status) {
          case CoffeeBillsStatus.activeLoading:
            return Stack(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: LinearProgressIndicator(minHeight: 3),
                ),
                Center(
                  child: SpinKitFadingCircle(
                    color: Colors.blue,
                    size: 60,
                  ),
                ),
              ],
            );
          case CoffeeBillsStatus.searchLoading:
            return Stack(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: LinearProgressIndicator(minHeight: 3),
                ),
              ],
            );

          case CoffeeBillsStatus.activeSuccess:
            if (state.bills.isEmpty) {
              return const Center(child: Text("لا توجد بيانات"));
            }
            return AllActiveBillsCoffeeListView(bills: state.bills);

          case CoffeeBillsStatus.activeFailure:
            return Center(child: Text("❌ ${state.errorMessage ?? 'حدث خطأ'}"));

          case CoffeeBillsStatus.empty:
            return const Center(child: Text("لا توجد بيانات"));

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

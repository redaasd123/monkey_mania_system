
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/manager/coffee_bills/coffee_bills_cubit.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/all_active/all_active_bills_coffee_list_view.dart';

class ActiveCoffeeListViewBuilder extends StatelessWidget {
  const ActiveCoffeeListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoffeeBillsCubit, CoffeeBillsState>(
      builder: (context, state) {
        if (state is ActiveCoffeeBillsSuccessState) {
          return AllActiveBillsCoffeeListView(bills: state.bills);
        }else if (state is BillsEmptyState){
          return Text('data');
        }else if( state is ActiveBillsSearchLoading){
          return Center(child: CircularProgressIndicator());
        }
        if (state is ActiveCoffeeBillsFailureState) {
          return Center(child: Text("❌ ${state.errMessage}"));
        }
        if (state is ActiveCoffeeBillsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return const SizedBox.shrink(); // Initial state
      },
      listener: (context, state) {
        if (state is ActiveCoffeeBillsFailureState) {
          showRedFlush(context, state.errMessage);
        }

        else if (state is ActiveCoffeeBillsSuccessState) {
        }else if (state is ActiveCoffeeBillsLoadingState){
        }
      },
    );
  }
}

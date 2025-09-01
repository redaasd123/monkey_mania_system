import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffee_bills_list_view.dart';
import 'package:monkey_app/feature/branch/presentation/manager/branch_cubit.dart';

import '../../manager/coffee_bills/coffee_bills_cubit.dart';

class CoffeeBillsViewBody extends StatelessWidget {
  const CoffeeBillsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(body: CoffeeBillsBuilder());
  }
}

class CoffeeBillsBuilder extends StatelessWidget {
  const CoffeeBillsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CoffeeBillsCubit, CoffeeBillsState>(
          listener: (context, state) {
            if (state is CoffeeBillsFailureState) {
              showRedFlush(context, state.errMessage);
            } else if (state is CoffeeBillsSuccessState) {
            } else if(state is GetOneBillsCoffeeSuccessState){
              showGreenFlush(context, 'success');
            }else if (state is GetOneBillsCoffeeLoadingState){
            }else if(state is GetOneBillsCoffeeFailureState){
              showRedFlush(context, state.errMessage);
            }else if(state is BranchSuccessState){
              showGreenFlush(context, 'success');
            }else if(state is BranchLoadingState){

            }
          },
        ),
        BlocListener<BranchCubit, BranchState>(
          listener: (context, state) {
           if(state is BranchSuccessState){
           }
           }
        ),
      ],
      child: BlocBuilder<CoffeeBillsCubit, CoffeeBillsState>(
        builder: (context, state) {
          if (state is CoffeeBillsSuccessState) {
            return CoffeeBillsListView();
          }else if (state is BillsEmptyState){
            return Text('data');
          } else if (state is BranchLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }else if(state is CoffeeBillsLoadingState){
            return const Center(child: CircularProgressIndicator());
          }else{
            return SizedBox();
          }
        },
      ),
    );
  }
}


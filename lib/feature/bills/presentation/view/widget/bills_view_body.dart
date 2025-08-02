import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';
import 'package:monkey_app/feature/bills/presentation/manager/bills_cubit.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/bills_view_body_item.dart';

import 'bills_list_view.dart';


class BillsViewBody extends StatelessWidget {
  const BillsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    return BlocConsumer<BillsCubit, BillsState>(
      listener: (context, state) {
        if(state is BillsLoadingState){
          showLoader(context);
        }else if(state is BillsFailureState){
          showRedFlush(context, state.errMessage);
        }else{
          showGreenFlush(context, "Success");
        }
      },
      builder: (context, state) {
        if(state is BillsSuccessState){
          return Scaffold(
            body: BillsListView(bills: state.bills,),
          );
        }else{
          return const SizedBox();
        }
      },
    );
  }
}


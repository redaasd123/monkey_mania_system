import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';

import '../../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../../manager/close_bills_cubit/close_bills_cubit.dart';
import '../../../manager/fetch_bills_cubit/bills_cubit.dart';
import 'all_active_list_view.dart';

class AllActiveBillsViewBody extends StatelessWidget {
  const AllActiveBillsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// 🔹 Create Bills جوه BillsCubit
        BlocListener<BillsCubit, BillsState>(
          listener: (context, state) async {
            if (state is CreateBillsFailureState) {
              showRedFlush(context, state.errMessage);
              hideLoader(context);
            } else if (state is CreateBillsSuccessState) {
              showGreenFlush(context, 'Success');
              hideLoader(context);
            } else if (state is CreateBillsLoadingState) {
              showLoader(context);
            }
          },
        ),

        /// 🔹 Apply Discount Cubit منفصل
        BlocListener<ApplyDiscountCubit, ApplyDiscountState>(
          listener: (context, state) async {
            if (state is ApplyDiscountFailureState) {
              showRedFlush(context, state.errMessage);
              hideLoader(context);
            } else if (state is ApplyDiscountSuccessState) {
              showGreenFlush(context, 'Discount Applied');
              hideLoader(context);
            } else if (state is ApplyDiscountLoadingState) {
              showLoader(context);
            }
          },
        ),

        /// 🔹 Close Bills Cubit منفصل
        BlocListener<CloseBillsCubit, CloseBillsState>(
          listener: (context, state) async {
            if (state is CloseBillsFailure) {
              showRedFlush(context, state.errMessage);
              hideLoader(context);
            } else if (state is CloseBillsSuccess) {
              showGreenFlush(context, 'Bill Closed');
              hideLoader(context);
            } else if (state is CloseBillsLoading) {
              showLoader(context);
            }
          },
        ),
      ],
      child: BlocBuilder<BillsCubit, BillsState>(
        builder: (context, state) {
          if (state is FetchActiveBillsSuccessState) {
            return AllActiveListView(bills: state.bills);
          }else if (state is CreateBillsFailureState){
            return AllActiveListView(bills: state.bills);
          } else if (state is BillsEmptyState) {
            return const Center(child: Text('No Data'));
          } else if (state is FetchActiveBillsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchActiveBillsFailureState) {
            return Center(child: Text(state.errMessage));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}









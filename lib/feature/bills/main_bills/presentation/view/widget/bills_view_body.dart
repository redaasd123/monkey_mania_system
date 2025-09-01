import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/funcation/show_snack_bar.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';

import '../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../manager/close_bills_cubit/close_bills_cubit.dart';
import '../../manager/fetch_bills_cubit/bills_cubit.dart';
import 'bills_list_view.dart';

class BillsViewBody extends StatelessWidget {
  const BillsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<BillsCubit, BillsState>(
          listener: (context, state) async {
            print("🔥 Current state: $state");
            if (state is BillsFailureState) {
              showRedFlush(context, state.errMessage);
            } else if (state is CreateBillsFailureState) {
              showRedFlush(context, state.errMessage);
            }  else if (state is CreateBillsSuccessState) {
              showGreenFlush(context, 'success');
            } else if (state is CreateBillsLoadingState) {
            }
          },
        ),

        BlocListener<ApplyDiscountCubit, ApplyDiscountState>(
          listener: (context, state) async {
            if (state is ApplyDiscountFailureState) {
              showRedFlush(context, state.errMessage);
              hideLoader(context);
            } else if (state is ApplyDiscountSuccessState) {
              showGreenFlush(context, 'success');
              hideLoader(context);
            } else if (state is ApplyDiscountLoadingState) {
              showLoader(context);
            }
          },
        ),

        BlocListener<CloseBillsCubit, CloseBillsState>(
          listener: (context, state) async {
            if (state is CloseBillsFailure) {
              showRedFlush(context, state.errMessage);
              hideLoader(context);
            } else if (state is CloseBillsSuccess) {
              showGreenFlush(context, 'success');
              hideLoader(context);
            } else if (state is CloseBillsLoading) {
              showLoader(context);
            }
          },
        ),
      ],
      child: BlocBuilder<BillsCubit, BillsState>(
        builder: (context, state) {
          if (state is BillsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }  else if (state is BillsSuccessState) {
            return BillsListView(bills: state.bills);
          } else if (state is BillsEmptyState) {
            return const Center(child: Text('No bills found'));
          }else if (state is BillsFailureState) {
            return Center(child: Text(state.errMessage));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

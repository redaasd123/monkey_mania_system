import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';

import '../../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../../manager/close_bills_cubit/close_bills_cubit.dart';
import '../../../manager/create_bills_cubit/create_bills_cubit.dart';
import '../../../manager/ferch_activ_bills/fetch_active_bills_cubit.dart';
import '../param/fetch_bills_param.dart';
import 'all_active_list_view.dart';

class AllActiveBillsViewBody extends StatelessWidget {
  const AllActiveBillsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FetchActiveBillsCubit, FetchActiveBillsState>(
          listener: (context, state) {
            if (state is FetchActiveBillsFailureState) {
              showRedFlush(context, state.errMessage);
            } else if (state is FetchActiveBillsSuccessState) {
              showGreenFlush(context, 'Bills fetched successfully');
            }
          },
        ),
        BlocListener<CreateBillsCubit, CreateBillsState>(
          listener: (context, state) async {
            if (state is CreateBillsFailureState) {
              showRedFlush(context, state.errMessage);
              await BlocProvider.of<FetchActiveBillsCubit>(
                context,
              ).fetchActiveBills(FetchBillsParam(branch: ['all']));
              hideLoader(context);
            } else if (state is CreateBillsSuccessState) {
              await BlocProvider.of<FetchActiveBillsCubit>(
                context,
              ).fetchActiveBills(FetchBillsParam(branch: ['all']));
              showGreenFlush(context, 'success');
              hideLoader(context);
            } else {
              showLoader(context);
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
            } else {
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
            } else {
              showLoader(context);
            }
          },
        ),
      ],
      child: BlocBuilder<FetchActiveBillsCubit, FetchActiveBillsState>(
        builder: (context, state) {
          if (state is FetchActiveBillsSuccessState) {
            return AllActiveListView(bills: state.bills);
          } else if (state is FetchActiveBillsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

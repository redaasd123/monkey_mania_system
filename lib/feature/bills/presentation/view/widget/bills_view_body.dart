import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';
import 'package:monkey_app/feature/bills/presentation/manager/apply_discount_cubit/apply_discount_cubit.dart';
import 'package:monkey_app/feature/bills/presentation/manager/create_bills_cubit/create_bills_cubit.dart';
import 'package:monkey_app/feature/bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../../manager/close_bills_cubit/close_bills_cubit.dart';
import 'bills_list_view.dart';

class BillsViewBody extends StatelessWidget {
  const BillsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<BillsCubit, BillsState>(
          listener: (context, state) {
            if (state is BillsSuccessState) {
            } else if (state is BillsFailureState) {
              BlocProvider.of<BillsCubit>(
                context,
              ).fetchBills(FetchBillsParam(branch: ['all']));
              showRedFlush(context, state.errMessage);
            }
          },
        ),
        BlocListener<CreateBillsCubit, CreateBillsState>(
          listener: (context, state) async {
            if (state is CreateBillsFailureState) {
              showRedFlush(context, state.errMessage);
             await BlocProvider.of<BillsCubit>(
                context,
              ).fetchBills(FetchBillsParam(branch: ['all']));
              hideLoader(context);
            } else if (state is CreateBillsSuccessState) {
             await BlocProvider.of<BillsCubit>(
                context,
              ).fetchBills(FetchBillsParam(branch: ['all']));
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
      child: BlocBuilder<BillsCubit, BillsState>(
        builder: (context, state) {
          if (state is BillsSuccessState) {
            return BillsListView(bills: state.bills);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/bills_view_body.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../manager/fetch_bills_cubit/bills_cubit.dart';

class BillsView extends StatelessWidget {
  const BillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BillsCubit>()..fetchBills(FetchBillsParam(branch: ['all'])),
      child: BillsViewBody(),
    );
  }
}

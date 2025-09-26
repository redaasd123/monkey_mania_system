import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../../../../../../core/helper/auth_helper.dart';
import '../../../manager/fetch_bills_cubit/bills_cubit.dart';
import 'all_ctive_bils_view_body.dart';

class GetAllActiveBillsView extends StatefulWidget {
  const GetAllActiveBillsView({super.key});

  @override
  State<GetAllActiveBillsView> createState() => _GetAllActiveBillsViewState();
}

class _GetAllActiveBillsViewState extends State<GetAllActiveBillsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BillsCubit>()
            ..fetchActiveBills(FetchBillsParam(branch: ['all'])),
      child: AllActiveBillsViewBody(),
    );
  }
}

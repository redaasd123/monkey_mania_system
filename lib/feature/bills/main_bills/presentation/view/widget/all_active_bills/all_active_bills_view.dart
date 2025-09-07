import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../manager/fetch_bills_cubit/bills_cubit.dart';
import '../param/create_bills_param.dart';
import '../show_bills_bottom_sheet.dart';
import 'all_ctive_bils_view_body.dart';

class GetAllActiveBillsView extends StatefulWidget {
  const GetAllActiveBillsView({super.key});

  @override
  State<GetAllActiveBillsView> createState() => _GetAllActiveBillsViewState();
}

class _GetAllActiveBillsViewState extends State<GetAllActiveBillsView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) =>
          getIt<BillsCubit>()..fetchActiveBills(FetchBillsParam(
            branch: ['all']
          )),
      child: AllActiveBillsViewBody(),
    );
  }
}

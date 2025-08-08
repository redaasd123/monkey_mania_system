import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/presentation/manager/create_bills_cubit/create_bills_cubit.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/create_bills_param.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/bills/presentation/manager/fetch_bills_cubit/bills_cubit.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/bills_view_body.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/show_bills_bottom_sheet.dart';

import '../../../branch/presentation/view/show_branch_bottom_sheet.dart';

class BillsView extends StatefulWidget {
  const BillsView({super.key});

  @override
  State<BillsView> createState() => _BillsViewState();
}

class _BillsViewState extends State<BillsView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          actions: [
            PopupMenuButton<String>(
              icon: Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: const Icon(Icons.more_vert, color: Colors.white),
              ),
              onSelected: (value) {
                if (value == 'branch') {
                  showBranchBottomSheet(
                    context,
                    onSelected: (param) {
                      print('📦 All Data: $param');
                      BlocProvider.of<BillsCubit>(context).fetchBills(param);
                    },
                  );
                }
              },

              itemBuilder: (context) =>
              [
                const PopupMenuItem<String>(
                  value: 'branch',
                  child: Text('Branch'),
                ),
              ],
            ),
          ],
        ),
        body: BillsViewBody(),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final data = await showBillsBottomSheet(context, 'Add Bills');
            final cubit = BlocProvider.of<CreateBillsCubit>(context);
            if (data != null) {
              print('🧪 Data from bottom sheet: $data');
              final param = CreateBillsParam(
                  discount: 'test-promo-percentage',
                  childrenId: data.childrenId,
                  newChildren: data.newChildren,
                  branch: data.branch);
              cubit.createBills(param);
            }
          },
        ),

    );
  }
}

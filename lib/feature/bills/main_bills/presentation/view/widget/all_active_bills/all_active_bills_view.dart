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
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<BillsCubit, BillsState>(
            builder: (context, state) {
              final cubit = context.read<BillsCubit>();
              return cubit.isSearching
                  ? TextField(
                      autofocus: true,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      cursorColor: colorScheme.onPrimary,
                      decoration: InputDecoration(
                        hintText: LangKeys.bills.tr(),
                        hintStyle: TextStyle(
                          color: colorScheme.onPrimary.withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        filled: true,
                        fillColor: colorScheme.primary,
                      ),
                      onChanged: (val) {
                        cubit.searchBills(val);
                      },
                    )
                  : Text(
                      LangKeys.bills.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    );
            },
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          actions: [
            IconButton(
              icon: BlocBuilder<BillsCubit, BillsState>(
                builder: (context, state) {
                  final cubit = context.read<BillsCubit>();
                  return Icon(cubit.isSearching ? Icons.close : Icons.search);
                },
              ),
              onPressed: () {
                setState(() {
                  context.read<BillsCubit>().toggleSearch();
                });
              },
            ),
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
                      BlocProvider.of<BillsCubit>(
                        context,
                      ).fetchActiveBills(param);
                    },
                  );
                }
              },

              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'branch',
                  child: Text('Branch'),
                ),
              ],
            ),
          ],
        ),
        body: AllActiveBillsViewBody(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final data = await showBillsBottomSheet(context, 'Add Bills');
            final cubit = BlocProvider.of<BillsCubit>(context);
            if (data != null) {
              print('🧪 Data from bottom sheet: $data');
              final param = CreateBillsParam(
                discount: 'test-promo-percentage',
                childrenId: data.childrenId,
                newChildren: data.newChildren,
                branch: data.branch,
              );
              cubit.createBills(param);
            }
          },
        ),
      ),
    );
  }
}

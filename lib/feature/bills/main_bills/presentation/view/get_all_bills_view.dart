import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/bills_view_body.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/create_bills_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/show_bills_bottom_sheet.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../manager/fetch_bills_cubit/bills_cubit.dart';

class BillsView extends StatefulWidget {
  const BillsView({super.key});

  @override
  State<BillsView> createState() => _BillsViewState();
}

class _BillsViewState extends State<BillsView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) =>
          getIt<BillsCubit>()..fetchBills(FetchBillsParam(branch: ['all'])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          title: BlocBuilder<BillsCubit, BillsState>(
            builder: (context, state) {
              final cubit = context.read<BillsCubit>();
              return cubit.isSearching
                  ? TextField(
                      autofocus: true,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      cursorColor: colorScheme.onPrimary,
                      decoration: InputDecoration(
                        hintText: LangKeys.school.tr(),
                        hintStyle: TextStyle(
                          color: colorScheme.onPrimary.withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        filled: true,
                        fillColor: colorScheme.primary,
                      ),
                      onChanged: (val) {
                        if (val.length >= 2) {
                          cubit.searchBills(val);
                        }
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
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) {
                if (value == 'branch') {
                  showBranchBottomSheet(
                    context,
                    onSelected: (param) {
                      context.read<BillsCubit>().fetchBills(param);
                    },
                  );
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem<String>(value: 'branch', child: Text('Branch')),
              ],
            ),
          ],
        ),

        body: const BillsViewBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            final data = await showBillsBottomSheet(
              context,
              LangKeys.bills.tr(),
            );
            if (data != null) {
              context.read<BillsCubit>().createBills(
                CreateBillsParam(
                  discount: data.discount,
                  childrenId: data.childrenId,
                  newChildren: data.newChildren,
                  branch: data.branch,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

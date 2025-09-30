import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/my_app_drwer.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';
import 'package:monkey_app/feature/expense/general_expense/presentation/manager/general_expense_cubit.dart';
import 'package:monkey_app/feature/expense/general_expense/presentation/view/widget/general_expense_view_body.dart';
import 'package:monkey_app/feature/expense/general_expense/presentation/view/widget/show_general_expense_bottom_sheet.dart';

import '../../../../../core/download_fiels/download_file.dart';
import '../../../../../core/helper/auth_helper.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/utils/poppup_menu_button.dart';
import '../../../../branch/presentation/view/show_branch_bottom_sheet.dart';

class GeneralExpenseView extends StatefulWidget {
  const GeneralExpenseView({super.key});

  @override
  State<GeneralExpenseView> createState() => _GeneralExpenseViewState();
}

class _GeneralExpenseViewState extends State<GeneralExpenseView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: MyAppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final data = await showGeneralExpenseBottomSheet(context, 'create ');
          if (data != null) {
            BlocProvider.of<GeneralExpenseCubit>(context).createGeneralExpense(
              CreateExpenseParam(
                name: data.name,
                branchId: data.branchId,
                totalPrice: data.totalPrice,
                quantity: data.quantity,
              ),
            );
          }
        },
      ),
      body: GeneralExpenseViewBody(),
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: BlocBuilder<GeneralExpenseCubit, GeneralExpenseState>(
          builder: (context, state) {
            final cubit = context.read<GeneralExpenseCubit>();
            return state.isSearching
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
        actions: [
          IconButton(
            icon: BlocBuilder<GeneralExpenseCubit, GeneralExpenseState>(
              builder: (context, state) {
                return Icon(state.isSearching ? Icons.close : Icons.search);
              },
            ),
            onPressed: () {
              setState(() {
                context.read<GeneralExpenseCubit>().toggleSearch();
              });
            },
          ),
          CustomPopupMenu(
            onBranch: () {
              showBranchBottomSheet(
                context,
                onSelected: (param) {
                  final cubit = context.read<GeneralExpenseCubit>();
                  final updatedFilters = cubit.state.filters.copyWith(
                    branch: param.branch,
                    startDate: param.startDate,
                    endDate: param.endDate,
                  );
                  cubit.setParam(updatedFilters);
                  cubit.fetchAllGeneralExpense(updatedFilters);
                },
              );
            },

            onDownload: () async {
              final cubit = context.read<GeneralExpenseCubit>().state;
              await requestStoragePermission();
              final downloader = FileDownloaderUI();
              final param = cubit.filters;
              final url =
                  '${kBaseUrl}general_expense/all?is_csv_response=true&${param.toQueryParams()}';
              print("📤 Download Started");
              print("🔍 Search Query: ${cubit.searchQuery}");
              print("🛠️ Param (toQueryParams): ${param.toQueryParams()}");
              print("🌍 URL: $url");
              print("📂 File Name: allBills.csv");
              await downloader.downloadFile(context, url, 'general_expense.csv');
            },
          ),
        ],
      ),
    );
  }
}

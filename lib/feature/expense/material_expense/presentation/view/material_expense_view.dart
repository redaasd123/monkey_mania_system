import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/manager/material_expense_cubit.dart';
import 'package:monkey_app/feature/expense/material_expense/presentation/view/show_material_bottom_sheet.dart';

import '../../../../../core/download_fiels/download_file.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../../../core/utils/my_app_drwer.dart';
import '../../../../../core/utils/poppup_menu_button.dart';
import '../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../general_expense/domain/use_case/param/create_param.dart';
import 'material_expense_view_body.dart';

class MaterialExpenseView extends StatefulWidget {
  const MaterialExpenseView({super.key});

  @override
  State<MaterialExpenseView> createState() => _MaterialExpenseViewState();
}

class _MaterialExpenseViewState extends State<MaterialExpenseView> {
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: MyAppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final data = await showMaterialExpenseBottomSheet(context, 'create ');
          if (data != null) {
            BlocProvider.of<MaterialExpenseCubit>(
              context,
            ).createMaterialExpense(
              CreateExpenseParam(
                materialId: data.materialId,
                branchId: data.branchId,
                totalPrice: data.totalPrice,
                quantity: data.quantity,
              ),
            );
          }
        },
      ),
      body: MaterialExpenseViewBody(),
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: BlocBuilder<MaterialExpenseCubit, MaterialExpenseState>(
          builder: (context, state) {
            final cubit = context.read<MaterialExpenseCubit>();
            return state.isSearching
                ? TextField(
                    autofocus: true,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    cursorColor: colorScheme.onPrimary,
                    decoration: InputDecoration(
                      hintText: LangKeys.search.tr(),
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
                    LangKeys.material.tr(),
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
            icon: BlocBuilder<MaterialExpenseCubit, MaterialExpenseState>(
              builder: (context, state) {
                return Icon(state.isSearching ? Icons.close : Icons.search);
              },
            ),
            onPressed: () {
              setState(() {
                context.read<MaterialExpenseCubit>().toggleSearch();
              });
            },
          ),
          CustomPopupMenu(
            onBranch: () {
              showBranchBottomSheet(
                context,
                onSelected: (param) {
                  final cubit = context.read<MaterialExpenseCubit>();
                  final updatedFilters = cubit.state.filters.copyWith(
                    branch: param.branch,
                    startDate: param.startDate,
                    endDate: param.endDate,
                  );
                  cubit.setParam(updatedFilters);
                  cubit.fetchAllMaterialExpense(updatedFilters);
                },
              );
            },

            onDownload: () async {
              final cubit = context.read<MaterialExpenseCubit>().state;
              await requestStoragePermission();
              final downloader = FileDownloaderUI();
              final param = cubit.filters;
              final url =
                  '${kBaseUrl}material_expense/all?is_csv_response=true&${param.toQueryParams()}';
              await downloader.downloadFile(context, url, ',material_expense.csv');
            },
          ),

        ],
      ),
    );
  }
}

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

import '../../../../../core/helper/auth_helper.dart';
import '../../../../../core/utils/langs_key.dart';
import '../../../../bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
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
          PopupMenuButton<String>(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900]!.withOpacity(0.95)
                : Colors.white.withOpacity(0.95),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 10,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFC971E4), Color(0xFFC0A7C6)],
                  // بنفسجي → أزرق
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.more_vert, color: Colors.white, size: 22),
            ),
            onSelected: (value) {
              if (value == 'branch') {
                showBranchBottomSheet(
                  context,
                  onSelected: (param){
                    context.read<GeneralExpenseCubit>().fetchAllGeneralExpense(
                     param
                    );
                    print('${param.branch}');
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'branch',
                child: Row(
                  children: [
                    Icon(
                      Icons.store_mall_directory,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Branch',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

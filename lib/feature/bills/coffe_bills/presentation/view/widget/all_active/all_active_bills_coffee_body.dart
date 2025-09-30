import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/download_fiels/download_file.dart';
import '../../../../../../../core/utils/constans.dart';
import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../../core/utils/my_app_drwer.dart';
import '../../../../../../../core/utils/poppup_menu_button.dart';
import '../../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../manager/coffee_bills/coffee_bills_cubit.dart';
import 'all_active_bills_builder.dart';

class AllActiveBillsCoffeeBody extends StatefulWidget {
  const AllActiveBillsCoffeeBody({super.key});

  @override
  State<AllActiveBillsCoffeeBody> createState() =>
      _AllActiveBillsCoffeeBodyState();
}

class _AllActiveBillsCoffeeBodyState extends State<AllActiveBillsCoffeeBody> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: const MyAppDrawer(),
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: BlocBuilder<CoffeeBillsCubit, BillsCoffeeState>(
          builder: (context, state) {
            final cubit = context.read<CoffeeBillsCubit>();
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
                      cubit.searchActiveBills(val);
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
            icon: BlocBuilder<CoffeeBillsCubit, BillsCoffeeState>(
              builder: (context, state) {
                return Icon(state.isSearching ? Icons.close : Icons.search);
              },
            ),
            onPressed: () {
              setState(() {
                context.read<CoffeeBillsCubit>().toggleSearch();
              });
            },
          ),

          //
          CustomPopupMenu(
            onBranch: () {
              showBranchBottomSheet(
                context,
                onSelected: (param) {
                  final update = context
                      .read<CoffeeBillsCubit>()
                      .state
                      .filters
                      .copyWith(
                        branch: param.branch,
                        startDate: param.startDate,
                        endDate: param.endDate,
                      );
                  context.read<CoffeeBillsCubit>().setParam(
                    update,
                  );
                  context.read<CoffeeBillsCubit>().fetchActiveBillsCoffee(
                    param,
                  );
                },
              );
            },
            onDownload: () async {
              final cubit = context.read<CoffeeBillsCubit>().state;
              await requestStoragePermission();
              final downloader = FileDownloaderUI();
              final param = cubit.filters;
              final url =
                  '${kBaseUrl}product_bill/active/all?is_csv_response=true&${param.toQueryParams()}';
              print("📤 Download Started");
              print("🔍 Search Query: ${cubit.searchQuery}");
              print("🛠️ Param (toQueryParams): ${param.toQueryParams()}");
              print("🌍 URL: $url");
              print("📂 File Name: allBills.csv");
              await downloader.downloadFile(
                context,
                url,
                'ActiveCoffeeBills.csv',
              );
            },
          ),
        ],
      ),
      body: ActiveCoffeeListViewBuilder(),
    );
  }
}

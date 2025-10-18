import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffee_bills_list_view.dart';

import '../../../../../../core/download_fiels/download_file.dart';
import '../../../../../../core/secret/secret.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/utils/my_app_drwer.dart';
import '../../../../../../core/utils/poppup_menu_button.dart';
import '../../../../../../core/widget/widget/custom_show_loder.dart';
import '../../../../../branch/presentation/manager/branch_cubit.dart';
import '../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../manager/coffee_bills/coffee_bills_cubit.dart';

class CoffeeBillsViewBody extends StatefulWidget {
  const CoffeeBillsViewBody({super.key});

  @override
  State<CoffeeBillsViewBody> createState() => _CoffeeBillsViewBodyState();
}

class _CoffeeBillsViewBodyState extends State<CoffeeBillsViewBody> {
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
          CustomPopupMenu(
            onBranch: () {
              showBranchBottomSheet(
                context,
                onSelected: (param) {
                  final updateParam = context
                      .read<CoffeeBillsCubit>()
                      .state
                      .filters
                      .copyWith(
                        branch: param.branch,
                        startDate: param.startDate,
                        endDate: param.endDate,
                      );
                  context.read<CoffeeBillsCubit>().setParam(updateParam);
                  context.read<CoffeeBillsCubit>().fetchBillsCoffee(param);
                },
              );
            },
            onDownload: () async {
              final cubit = context.read<CoffeeBillsCubit>().state;
              await requestStoragePermission();
              final downloader = FileDownloaderUI();
              final param = cubit.filters;
              final url =
                  '${kBaseUrl}product_bill/all?is_csv_response=true&${param.toQueryParams()}';
              await downloader.downloadFile(context, url, 'allCoffeeBills.csv');
            },
          ),
        ],
      ),
      body: CoffeeBillsBuilder(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kCreateCoffeeBillsView);
        },
      ),
    );
  }
}

class CoffeeBillsBuilder extends StatelessWidget {
  const CoffeeBillsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BranchCubit, BranchState>(
          listener: (context, state) {
            if (state.status == BranchStatus.selected &&
                state.selectedBranchId != null) {
              context.read<CoffeeBillsCubit>().fetchBillsCoffee(
                RequestParameters(branch: [state.selectedBranchId!]),
              );
            }
          },
        ),

        BlocListener<CoffeeBillsCubit, BillsCoffeeState>(
          listener: (context, state) {
            if (state.status == CoffeeBillsStatus.failure ||
                state.status == CoffeeBillsStatus.activeFailure ||
                state.status == CoffeeBillsStatus.returnProductFailure ||
                state.status == CoffeeBillsStatus.createFailure) {
              hideLoader(context);
              showRedFlush(context, state.errorMessage ?? "حدث خطأ");
            }
          },
        ),
      ],
      child: BlocBuilder<CoffeeBillsCubit, BillsCoffeeState>(
        builder: (context, state) {
          switch (state.status) {
            case CoffeeBillsStatus.loading:
            case CoffeeBillsStatus.activeLoading:
            case CoffeeBillsStatus.returnProductLoading:
              return Stack(
                children: [
                  const Center(
                    child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                  ),
                  const LinearProgressIndicator(minHeight: 3),
                ],
              );

            case CoffeeBillsStatus.success:
            case CoffeeBillsStatus.createSuccess:
            case CoffeeBillsStatus.activeSuccess:
            case CoffeeBillsStatus.returnProductSuccess:
              if (state.bills.isEmpty) {
                return const Center(child: Text("empty"));
              }
              return CoffeeBillsListView(bills: state.bills);

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

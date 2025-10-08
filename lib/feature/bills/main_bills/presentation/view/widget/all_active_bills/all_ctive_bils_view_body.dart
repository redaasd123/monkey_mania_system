import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/core/utils/styles.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';

import '../../../../../../../core/download_fiels/download_file.dart';
import '../../../../../../../core/helper/auth_helper.dart';
import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../../core/utils/my_app_drwer.dart';
import '../../../../../../../core/utils/poppup_menu_button.dart';
import '../../../../../../branch/presentation/manager/branch_cubit.dart';
import '../../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../../domain/use_case/param/create_bills_param.dart';
import '../../../../domain/use_case/param/fetch_bills_param.dart';
import '../../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../../manager/close_bills_cubit/close_bills_cubit.dart';
import '../../../manager/fetch_bills_cubit/bills_cubit.dart';

import '../show_bills_bottom_sheet.dart';
import 'all_active_list_view.dart';

class AllActiveBillsViewBody extends StatefulWidget {
  const AllActiveBillsViewBody({super.key});

  @override
  State<AllActiveBillsViewBody> createState() => _AllActiveBillsViewBodyState();
}

class _AllActiveBillsViewBodyState extends State<AllActiveBillsViewBody> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: const MyAppDrawer(),
      appBar: AppBar(
        title: BlocBuilder<BillsCubit, BillsState>(
          builder: (context, state) {
            final cubit = context.read<BillsCubit>();
            return state.isSearching
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
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: BlocBuilder<BillsCubit, BillsState>(
              builder: (context, state) {
                return Icon(state.isSearching ? Icons.close : Icons.search);
              },
            ),
            onPressed: () {
              setState(() {
                context.read<BillsCubit>().toggleSearch();
              });
            },
          ),
          CustomPopupMenu(
            onBranch: () {
              showBranchBottomSheet(
                context,
                onSelected: (param) {
                  final updated = context
                      .read<BillsCubit>()
                      .state
                      .filters
                      .copyWith(
                        branch: param.branch,
                        startDate: param.startDate,
                        endDate: param.endDate,
                      );
                  context.read<BillsCubit>().setParam(updated);
                  context.read<BillsCubit>().fetchActiveBills(updated);
                },
              );
            },
            onDownload: () async {
              final cubit = context.read<BillsCubit>().state;
              await requestStoragePermission();
              final downloader = FileDownloaderUI();
              final param = cubit.filters;
              final url =
                  '${kBaseUrl}bill/active/all?is_csv_response=true&${param.toQueryParams()}';
              await downloader.downloadFile(context, url, 'allActiveBills.csv');
            },
          ),
        ],
      ),
      body: AllActiveBillsConsumer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final data = await showBillsBottomSheet(context,  LangKeys.appName.tr());
          final cubit = BlocProvider.of<BillsCubit>(context);
          if (data != null) {
            final branch = AuthHelper.getBranch();
            final param = CreateBillsParam(
              discount: data.discount,
              childrenId: data.childrenId,
              newChildren: data.newChildren,
              branch: branch!,
            );
            cubit.createBills(param);
          }
        },
      ),
    );
  }
}

class AllActiveBillsConsumer extends StatelessWidget {
  const AllActiveBillsConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// 🔹 BillsCubit (Create + Active + Search)
        BlocListener<BillsCubit, BillsState>(
          listener: (context, state) async {
            switch (state.status) {
              case BillsStatus.createFailure:
                showRedFlush(
                  context,
                  state.errorMessage ?? 'Something went wrong',
                );
                hideLoader(context);
                break;

              case BillsStatus.createSuccess:
                showGreenFlush(context,  LangKeys.ok.tr());
                hideLoader(context);
                break;

              case BillsStatus.createLoading:
                showLoader(context);
                break;

              default:
                break;
            }
          },
        ),
        BlocListener<BranchCubit, BranchState>(
          listener: (context, state) {
            if (state is BranchSelectedState) {
              context.read<BillsCubit>().fetchActiveBills(
                FetchBillsParam(branch: [state.branchId]),
              );
            }
          },
        ),

        /// 🔹 Apply Discount Cubit
        BlocListener<ApplyDiscountCubit, ApplyDiscountState>(
          listener: (context, state) async {
            if (state is ApplyDiscountFailureState) {
              showRedFlush(context, state.errMessage);
              hideLoader(context);
            } else if (state is ApplyDiscountSuccessState) {
              showGreenFlush(context, LangKeys.ok.tr());
              hideLoader(context);
            } else if (state is ApplyDiscountLoadingState) {
              showLoader(context);
            }
          },
        ),

        /// 🔹 Close Bills Cubit
        BlocListener<CloseBillsCubit, CloseBillsState>(
          listener: (context, state) async {
            if (state is CloseBillsFailure) {
              showRedFlush(context, state.errMessage);
              hideLoader(context);
            } else if (state is CloseBillsSuccess) {
              await BlocProvider.of<BillsCubit>(
                context,
              ).fetchActiveBills(FetchBillsParam());
              showGreenFlush(context, LangKeys.ok.tr());
              hideLoader(context);
            } else if (state is CloseBillsLoading) {
              showLoader(context);
            }
          },
        ),
      ],
      child: BlocBuilder<BillsCubit, BillsState>(
        builder: (context, state) {
          switch (state.status) {
            case BillsStatus.activeSuccess:
            case BillsStatus.createSuccess:
              return AllActiveListView(bills: state.bills);
            case BillsStatus.createFailure:
              return AllActiveListView(bills: state.bills);

            case BillsStatus.empty:
              return  Center(
                child: Text(LangKeys.notFound.tr(), style: Styles.textStyle14),
              );

            case BillsStatus.searchLoading:
              return Stack(
                children: [
                  AllActiveListView(bills: state.bills),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(minHeight: 3),
                  ),
                ],
              );

            case BillsStatus.activeLoading:
              return Stack(
                children: [
                  AllActiveListView(bills: state.bills),
                  Center(
                    child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                  ),
                  LinearProgressIndicator(minHeight: 3),
                ],
              );

            case BillsStatus.activeFailure:
              return Center(child: Text(state.errorMessage ?? 'Error'));

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

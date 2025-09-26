import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/utils/poppup_menu_button.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/create_bills_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/show_bills_bottom_sheet.dart';

import '../../../../../../core/download_fiels/download_file.dart';
import '../../../../../../core/utils/constans.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/utils/my_app_drwer.dart';
import '../../../../../branch/presentation/manager/branch_cubit.dart';
import '../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../manager/close_bills_cubit/close_bills_cubit.dart';
import '../../manager/fetch_bills_cubit/bills_cubit.dart';
import 'bills_list_view.dart';

class BillsViewBody extends StatefulWidget {
  const BillsViewBody({super.key});

  @override
  State<BillsViewBody> createState() => _BillsViewBodyState();
}

class _BillsViewBodyState extends State<BillsViewBody> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: const MyAppDrawer(),
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: BlocBuilder<BillsCubit, BillsState>(
          builder: (context, state) {
            final cubit = context.read<BillsCubit>();
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
                  context.read<BillsCubit>().fetchBills(param);
                },
              );
            },
            onDownload: () async {
              final cubit = context.read<BillsCubit>().state;
              await requestStoragePermission();
              final downloader = FileDownloaderUI();
              final param = FetchBillsParam(query: cubit.searchQuery);

              await downloader.downloadFile(
                context,
                '${kBaseUrl}school/all/?is_csv_response=true&${param.toQueryParams()}',
                'schools.csv',
              );
            },
          ),
        ],
      ),

      body: const AllBillsBlocConsumer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final data = await showBillsBottomSheet(context, LangKeys.bills.tr());
          if (data != null) {
            context.read<BillsCubit>().createBills(
              CreateBillsParam(
                discount: '',
                childrenId: data.childrenId,
                newChildren: data.newChildren,
                branch: data.branch,
              ),
            );
          }
        },
      ),
    );
  }
}

class AllBillsBlocConsumer extends StatelessWidget {
  const AllBillsBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// 🔹 BillsCubit
        BlocListener<BillsCubit, BillsState>(
          listener: (context, state) async {
            switch (state.status) {
              case BillsStatus.createFailure:
                hideLoader(context);
                showRedFlush(context, state.errorMessage ?? 'Create failed');
                break;

              case BillsStatus.createSuccess:
                hideLoader(context);
                showGreenFlush(context, LangKeys.createdSuccessfully.tr());
                break;

              case BillsStatus.createLoading:
                showLoader(context);
                break;

              default:
                break;
            }
          },
        ),

        /// 🔹 Apply Discount Cubit
        BlocListener<ApplyDiscountCubit, ApplyDiscountState>(
          listener: (context, state) async {
            if (state is ApplyDiscountFailureState) {
              hideLoader(context);
              showRedFlush(context, state.errMessage);
            } else if (state is ApplyDiscountSuccessState) {
              hideLoader(context);
              showGreenFlush(context, 'Discount Applied');
            } else if (state is ApplyDiscountLoadingState) {
              showLoader(context);
            }
          },
        ),

        /// 🔹 Close Bills Cubit
        BlocListener<CloseBillsCubit, CloseBillsState>(
          listener: (context, state) async {
            if (state is CloseBillsFailure) {
              hideLoader(context);
              showRedFlush(context, state.errMessage);
            } else if (state is CloseBillsSuccess) {
              hideLoader(context);
              showGreenFlush(context, 'Bill Closed');
            } else if (state is CloseBillsLoading) {
              showLoader(context);
            }
          },
        ),

        /// 🔹 Branch Cubit (لما تختار برانش)
        BlocListener<BranchCubit, BranchState>(
          listener: (context, state) {
            if (state is BranchSelectedState) {
              // هنا ننده على BillsCubit ونجيب البيانات الخاصة بالـbranch الجديد
              context.read<BillsCubit>().fetchBills(
                FetchBillsParam(branch: [state.branchId]),
              );
            }
          },
        ),
      ],

      /// 🔹 Builder
      child: BlocBuilder<BillsCubit, BillsState>(
        builder: (context, state) {
          switch (state.status) {
            // ---------------- Loading ----------------
            case BillsStatus.searchLoading:
              return Stack(
                children: [
                  Center(
                    child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                  ),
                  LinearProgressIndicator(minHeight: 3),
                ],
              );

            case BillsStatus.loading:
              return Stack(
                children: [
                  Center(
                    child: SpinKitFadingCircle(color: Colors.blue, size: 60),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(minHeight: 3),
                  ),
                  BillsListView(bills: state.bills),
                ],
              );

            // ---------------- Success & Failure ----------------
            case BillsStatus.success:
            case BillsStatus.failure:
            case BillsStatus.createFailure:
            case BillsStatus.createSuccess:
              return BillsListView(bills: state.bills);

            // ---------------- Empty ----------------
            case BillsStatus.empty:
              return const Center(child: Text('No bills found'));

            // ---------------- Default ----------------
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

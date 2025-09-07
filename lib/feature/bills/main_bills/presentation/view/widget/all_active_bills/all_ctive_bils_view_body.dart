import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/styles.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/core/widget/widget/custom_show_loder.dart';

import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../manager/apply_discount_cubit/apply_discount_cubit.dart';
import '../../../manager/close_bills_cubit/close_bills_cubit.dart';
import '../../../manager/fetch_bills_cubit/bills_cubit.dart';
import '../param/create_bills_param.dart';
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
                    print('${param.branch}😀😀😀😀😀😀');
                    context.read<BillsCubit>().fetchActiveBills(param);
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
      body: AllActiveBillsConsumer(),
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
    );
    ;
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
                showGreenFlush(context, 'Success');
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

        /// 🔹 Apply Discount Cubit
        BlocListener<ApplyDiscountCubit, ApplyDiscountState>(
          listener: (context, state) async {
            if (state is ApplyDiscountFailureState) {
              showRedFlush(context, state.errMessage);
              hideLoader(context);
            } else if (state is ApplyDiscountSuccessState) {
              showGreenFlush(context, 'Discount Applied');
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
              showGreenFlush(context, 'Bill Closed');
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
              return AllActiveListView(bills: state.bills);

            case BillsStatus.createFailure:
              return AllActiveListView(bills: state.bills);

            case BillsStatus.empty:
              return const Center(
                child: Text('No Data', style: Styles.textStyle14),
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
                  Center(child: CircularProgressIndicator()),
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

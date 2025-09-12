import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/utils/constans.dart';
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

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(kFlowers3)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                    colors: [
                      Color(0xFFC971E4),
                      Color(0xFFC0A7C6),
                    ], // بنفسجي → أزرق
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
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              onSelected: (value) {
                if (value == 'branch') {
                  showBranchBottomSheet(
                    context,
                    onSelected: (param) {
                      context.read<BillsCubit>().fetchActiveBills(param);
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
                  Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue, // غير اللون زي ما تحب
                      size: 60,
                    ),
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffee_bills_list_view.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/utils/my_app_drwer.dart';
import '../../../../../../core/widget/widget/custom_show_loder.dart';
import '../../../../../branch/presentation/manager/branch_cubit.dart';
import '../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
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
                  onSelected: (param) async {
                    // بعد كده ابعت الريكوست للـ API باستخدام البرانش اللي اتخزن
                    context.read<CoffeeBillsCubit>().fetchBillsCoffee(param);

                    // طباعتها للتأكد
                    print('Selected branch(s): ${param.branch}');
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
            if (state is BranchSelectedState) {
              context.read<CoffeeBillsCubit>().fetchBillsCoffee(
                FetchBillsParam(branch: [state.branchId]),
              );
            }
          },
        ),

        BlocListener<CoffeeBillsCubit, BillsCoffeeState>(
          listener: (context, state) {
            if (state.status == CoffeeBillsStatus.failure ||
                state.status == CoffeeBillsStatus.activeFailure ||
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

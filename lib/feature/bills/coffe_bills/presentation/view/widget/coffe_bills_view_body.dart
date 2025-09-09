import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/core/widget/widget/custom_flush.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/show_detail_coffee.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffee_bills_list_view.dart';

import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/langs_key.dart';
import '../../../../../../core/widget/widget/custom_show_loder.dart';
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
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'branch') {
                showBranchBottomSheet(
                  context,
                  onSelected: (param) {
                    context.read<CoffeeBillsCubit>().fetchBillsCoffee(param);
                    print('${param.branch}');
                  },
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem<String>(value: 'branch', child: Text('Branch')),
            ],
          ),
        ],
      ),
      body: CoffeeBillsBuilder(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        GoRouter.of(context).push(AppRouter.kCreateCoffeeBillsView);

      }),
    );
  }
}

class CoffeeBillsBuilder extends StatelessWidget {
  const CoffeeBillsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoffeeBillsCubit, BillsCoffeeState>(
      listener: (context, state) {
        // ---------------- Failure ----------------
        if (state.status == CoffeeBillsStatus.failure ||
            state.status == CoffeeBillsStatus.activeFailure ||
            state.status == CoffeeBillsStatus.createFailure) {
          hideLoader(context);
          showRedFlush(context, state.errorMessage ?? "حدث خطأ");
        }

        // ---------------- Loading ----------------
      },
      builder: (context, state) {
        switch (state.status) {
          // ---------------- Loading ----------------
          case CoffeeBillsStatus.loading:
          case CoffeeBillsStatus.activeLoading:
            return Stack(
              children: [
                Center(child: CircularProgressIndicator()),
                LinearProgressIndicator(minHeight: 3),
              ],
            );

          // ---------------- Search Loading ----------------
          case CoffeeBillsStatus.searchLoading:
            return Stack(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: LinearProgressIndicator(minHeight: 3),
                ),
              ],
            );

          // ---------------- Success ----------------
          case CoffeeBillsStatus.createSuccess:
          case CoffeeBillsStatus.success:
          case CoffeeBillsStatus.activeSuccess:
            if (state.bills.isEmpty) {
              return const Center(child: Text("لا توجد بيانات"));
            }
            return CoffeeBillsListView(bills: state.bills);



          // ---------------- Empty ----------------
          case CoffeeBillsStatus.empty:
            return const Center(child: Text("لا توجد بيانات"));


          // ---------------- Default ----------------
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

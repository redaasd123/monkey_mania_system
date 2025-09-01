import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../../../../core/utils/langs_key.dart';
import '../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../manager/coffee_bills/coffee_bills_cubit.dart';
import 'widget/coffe_bills_view_body.dart';

class CoffeeBillsView extends StatefulWidget {
  const CoffeeBillsView({super.key});

  @override
  State<CoffeeBillsView> createState() => _CoffeeBillsViewState();
}

class _CoffeeBillsViewState extends State<CoffeeBillsView> {
  late CoffeeBillsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<CoffeeBillsCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.fetchBillsCoffee(FetchBillsParam(branch: ['all']));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<CoffeeBillsCubit, CoffeeBillsState>(
            builder: (context, state) {
              return cubit.isSearching
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
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          actions: [
            IconButton(
              icon: Icon(cubit.isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  cubit.toggleSearch();
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
                      cubit.fetchBillsCoffee(param);
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
        body: CoffeeBillsViewBody(),
      ),
    );
  }
}

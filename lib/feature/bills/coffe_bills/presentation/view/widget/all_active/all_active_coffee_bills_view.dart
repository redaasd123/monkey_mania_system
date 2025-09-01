import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/all_active/all_active_bills_coffee_body.dart';

import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../../core/utils/service_locator.dart';
import '../../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../../../main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import '../../../manager/coffee_bills/coffee_bills_cubit.dart';

class AllActiveCoffeeBillsView extends StatefulWidget {
  const AllActiveCoffeeBillsView({super.key});

  @override
  State<AllActiveCoffeeBillsView> createState() => _AllActiveCoffeeBillsViewState();
}
late CoffeeBillsCubit cubit;
class _AllActiveCoffeeBillsViewState extends State<AllActiveCoffeeBillsView> {
  @override
  @override
  void initState() {
    super.initState();
    cubit = getIt<CoffeeBillsCubit>();

    // استدعاء الـ fetch بعد بناء الـ widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.fetchActiveBillsCoffee(FetchBillsParam(branch: ['all']));
    });
  }

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
                      cubit.fetchActiveBillsCoffee(param);
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
        body: AllActiveBillsCoffeeBody(),
      ),
    );
  }
}

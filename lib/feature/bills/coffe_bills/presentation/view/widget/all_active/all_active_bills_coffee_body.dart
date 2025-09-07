import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/all_active/all_active_bills_coffee_body.dart';

import '../../../../../../../core/utils/langs_key.dart';
import '../../../../../../../core/utils/service_locator.dart';
import '../../../../../../branch/presentation/view/show_branch_bottom_sheet.dart';
import '../../../../../main_bills/presentation/view/widget/param/fetch_bills_param.dart';
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
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'branch') {
                showBranchBottomSheet(
                  context,
                  onSelected: (param) {
                    context.read<CoffeeBillsCubit>().fetchActiveBillsCoffee(param);
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
      body: ActiveCoffeeListViewBuilder(),
    );
  }
}

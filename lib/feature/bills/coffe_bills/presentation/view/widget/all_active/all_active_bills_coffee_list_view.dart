import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';

import '../../../../../../../core/utils/app_router.dart';
import '../../../manager/coffee_bills/coffee_bills_cubit.dart';
import '../../show_detail_coffee.dart';
import '../coffe_bills_item.dart';

class AllActiveBillsCoffeeListView extends StatelessWidget {
  const AllActiveBillsCoffeeListView({super.key, required this.bills});

  final List<BillsCoffeeEntity> bills;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<CoffeeBillsCubit>(context).onRefreshActive(),
      child: ListView.builder(
        itemCount: bills.length,
        itemBuilder: (context, index) {
          final cubit = BlocProvider.of<CoffeeBillsCubit>(context);
          final modal = bills[index];
          return GestureDetector(
           onTap: (){},
            child: CoffeeBillsItem(
                onTap: () {
                  GoRouter.of(context).push(
                    AppRouter.kShowDetailCoffeeBills,
                    extra: modal.id,
                  );
                },
                billsCoffeeEntity: modal),
          );
        },
      ),
    );
  }
}

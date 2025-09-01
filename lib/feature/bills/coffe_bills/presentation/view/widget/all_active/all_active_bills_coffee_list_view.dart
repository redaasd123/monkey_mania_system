import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';

import '../../../../../../../core/utils/app_router.dart';
import '../coffe_bills_item.dart';

class AllActiveBillsCoffeeListView extends StatelessWidget {
  const AllActiveBillsCoffeeListView({super.key, required this.bills});
final List<BillsCoffeeEntity> bills;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bills.length,
      itemBuilder: (context, index) {
        final reverseIndex = bills.length - 1 - index;
        final modal = bills[reverseIndex];
        return GestureDetector(
          onTap: () {
            GoRouter.of(
              context,
            ).push(AppRouter.kShowDetailCoffeeBills, extra: modal.id);
          },
          child: CoffeeBillsItem(
            billsCoffeeEntity: bills[reverseIndex],
          ),
        );
      },
    );
  }
}

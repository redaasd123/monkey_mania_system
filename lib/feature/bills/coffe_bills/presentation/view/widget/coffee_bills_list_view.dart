import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/presentation/view/widget/coffe_bills_item.dart';

import '../../../../../../core/utils/app_router.dart';

class CoffeeBillsListView extends StatefulWidget {
  const CoffeeBillsListView({super.key, required this.bills});

  final List<BillsCoffeeEntity> bills;

  @override
  State<CoffeeBillsListView> createState() => _CoffeeBillsListViewState();
}

class _CoffeeBillsListViewState extends State<CoffeeBillsListView> {
  final visaCtrl = TextEditingController();
  final cashCtrl = TextEditingController();
  final instCtrl = TextEditingController();

  @override
  void dispose() {
    visaCtrl.dispose();
    cashCtrl.dispose();
    instCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      itemCount: widget.bills.length,
      itemBuilder: (context, index) {
        final reverseIndex = widget.bills.length - 1 - index;
        final modal = widget.bills[reverseIndex];
        return GestureDetector(
          onTap: () {
            GoRouter.of(
              context,
            ).push(AppRouter.kShowDetailCoffeeBills, extra: modal.id);
          },
          child: CoffeeBillsItem(billsCoffeeEntity: widget.bills[reverseIndex]),
        );
      },
    );
  }
}

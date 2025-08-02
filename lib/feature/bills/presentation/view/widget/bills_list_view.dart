import 'package:flutter/cupertino.dart';
import 'package:monkey_app/feature/bills/domain/entity/Bills_entity.dart';
import 'package:monkey_app/feature/bills/presentation/view/widget/bills_view_body_item.dart';

class BillsListView extends StatelessWidget {
  const BillsListView({super.key, required this.bills});
final List<BillsEntity> bills;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: bills.length ,
        itemBuilder: (context,index){
      return BillsViewBodyItem(bills: bills[index],);
    });
  }
}

import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';

class BillsCoffeePageEntity {
  final List<BillsCoffeeEntity> billsCoffeeEntity;
  final int? nextPage;
  final int? previousPage;

  BillsCoffeePageEntity({
    required this.billsCoffeeEntity,
    this.nextPage,
    this.previousPage,
  });
}

import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';

class BillsCoffeePageEntity extends Equatable{
  final List<BillsCoffeeEntity> billsCoffeeEntity;
  final int? nextPage;
  final int? previousPage;

const  BillsCoffeePageEntity({
    required this.billsCoffeeEntity,
    this.nextPage,
    this.previousPage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [billsCoffeeEntity,nextPage,previousPage];
}

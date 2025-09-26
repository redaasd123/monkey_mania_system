import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';

import 'material_expense_item_entity.dart';

class MaterialExpenseEntity extends Equatable {
  final String next;
  final String previous;
  final List<MaterialExpenseItemEntity> results;

  const MaterialExpenseEntity({
    required this.next,
    required this.previous,
    required this.results,
  });

  List<Object?> get props => [next, previous, results];
}

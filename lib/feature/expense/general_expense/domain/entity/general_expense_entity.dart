import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';

class GeneralExpenseEntity extends Equatable {
  final String next;
  final String previous;
  final List<GeneralExpenseItemEntity> results;

  const GeneralExpenseEntity({
    required this.next,
    required this.previous,
    required this.results,
  });

  List<Object?> get props => [next, previous, results];
}

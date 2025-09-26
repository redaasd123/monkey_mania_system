import 'package:monkey_app/feature/expense/general_expense/data/model/general_expense_model.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';

extension GetAllGeneralExpense on GeneralExpenseModel {
  GeneralExpenseEntity toEntity() {
    return GeneralExpenseEntity(
      next: next ?? '',
      previous: previous,
      results: results?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension GetAllGeneralExpenseItem on ResultsGeneralExpenseModel {
  GeneralExpenseItemEntity toEntity() {
    return GeneralExpenseItemEntity(
      quantity: quantity??1,
      name: name ?? "",
      unitPrice: unitPrice ?? "",
      totalPrice: totalPrice ?? '',
      id: id ?? 0,
    );
  }
}

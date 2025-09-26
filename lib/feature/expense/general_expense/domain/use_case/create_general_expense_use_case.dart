import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/repo/general_repo.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';

class CreateGeneralExpenseUseCase
    extends MyUseCase<GeneralExpenseItemEntity, CreateExpenseParam> {
  final GeneralExpenseRepo generalExpenseRepo;

  CreateGeneralExpenseUseCase({required this.generalExpenseRepo});
  @override
  Future<Either<Failure, GeneralExpenseItemEntity>> call(
    CreateExpenseParam param,
  )async {
    return await generalExpenseRepo.createGeneralExpense(param);
  }
}

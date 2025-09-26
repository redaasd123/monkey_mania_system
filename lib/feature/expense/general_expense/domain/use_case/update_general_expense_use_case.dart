import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/repo/general_repo.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/update_param.dart';

class UpdateGeneralExpenseUseCase
    extends MyUseCase<GeneralExpenseItemEntity, UpdateExpenseParam> {
  final GeneralExpenseRepo generalExpenseRepo;

  UpdateGeneralExpenseUseCase({required this.generalExpenseRepo});
  @override
  Future<Either<Failure, GeneralExpenseItemEntity>> call(
      UpdateExpenseParam param,
      )async {
    return await generalExpenseRepo.updateGeneralExpense(param);
  }
}

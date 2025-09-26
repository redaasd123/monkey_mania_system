import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/repo/general_repo.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/update_param.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/repo/material_repo.dart';

class UpdateMaterialExpenseUseCase
    extends MyUseCase<MaterialExpenseItemEntity, UpdateExpenseParam> {
  final MaterialExpenseRepo materialExpenseRepo;

  UpdateMaterialExpenseUseCase({required this.materialExpenseRepo});
  @override
  Future<Either<Failure, MaterialExpenseItemEntity>> call(
      UpdateExpenseParam param,
      )async {
    return await materialExpenseRepo.updateMaterialExpense(param);
  }
}

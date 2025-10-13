import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/repo/general_repo.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/repo/material_repo.dart';

class MaterialExpenseUseCase
    extends MyUseCase<MaterialExpenseEntity, RequestParameters> {
  @override
  final MaterialExpenseRepo materialExpenseRepo;

  MaterialExpenseUseCase({required this.materialExpenseRepo});

  Future<Either<Failure,MaterialExpenseEntity>> call(
    RequestParameters param,
  ) async {
    return await materialExpenseRepo.fetchMaterialExpense(param);
  }
}

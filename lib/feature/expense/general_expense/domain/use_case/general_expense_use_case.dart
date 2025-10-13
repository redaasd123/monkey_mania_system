import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/repo/general_repo.dart';

class GeneralExpenseUseCase
    extends MyUseCase<GeneralExpenseEntity, RequestParameters> {
  @override
  final GeneralExpenseRepo generalExpenseRepo;

  GeneralExpenseUseCase({required this.generalExpenseRepo});

  Future<Either<Failure,GeneralExpenseEntity>> call(
    RequestParameters param,
  ) async {
    return await generalExpenseRepo.fetchAllGeneralExpense(param);
  }
}

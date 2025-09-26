import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/use_case/use_case.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/repo/general_repo.dart';

class GeneralExpenseUseCase
    extends MyUseCase<GeneralExpenseEntity, FetchBillsParam> {
  @override
  final GeneralExpenseRepo generalExpenseRepo;

  GeneralExpenseUseCase({required this.generalExpenseRepo});

  Future<Either<Failure,GeneralExpenseEntity>> call(
    FetchBillsParam param,
  ) async {
    return await generalExpenseRepo.fetchAllGeneralExpense(param);
  }
}

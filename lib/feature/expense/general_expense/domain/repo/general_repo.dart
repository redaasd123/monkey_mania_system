import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/failure.dart';
import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';

import '../entity/general_expense_item_entity.dart';
import '../use_case/param/update_param.dart';

abstract class GeneralExpenseRepo {
  Future<Either<Failure, GeneralExpenseEntity>> fetchAllGeneralExpense(
    FetchBillsParam param,
  );

  Future<Either<Failure, GeneralExpenseItemEntity>> createGeneralExpense(
      CreateExpenseParam param,
      );

  Future<Either<Failure, GeneralExpenseItemEntity>> updateGeneralExpense(
      UpdateExpenseParam param,
      );
}

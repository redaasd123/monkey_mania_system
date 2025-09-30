import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/expense/general_expense/data/data_source/general_expense_remote_data_source.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/entity/general_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/repo/general_repo.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/create_param.dart';
import 'package:monkey_app/feature/expense/general_expense/domain/use_case/param/update_param.dart';

import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';

class GeneralExpenseImpl extends GeneralExpenseRepo {
  final GeneralExpenseRemoteDataSource remoteDataSource;

  GeneralExpenseImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, GeneralExpenseEntity>> fetchAllGeneralExpense(
    FetchBillsParam param,
  ) async {
    try {
      var result = await remoteDataSource.fetchGeneralExpense(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, GeneralExpenseItemEntity>> createGeneralExpense(
    CreateExpenseParam param,
  ) async {
    try {
      var result = await remoteDataSource.createGeneralExpense(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, GeneralExpenseItemEntity>> updateGeneralExpense(
    UpdateExpenseParam param,
  ) async {
    try {
      var result = await remoteDataSource.updateGeneralExpense(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}

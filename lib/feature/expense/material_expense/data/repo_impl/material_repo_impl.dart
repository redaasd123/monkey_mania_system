import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/expense/material_expense/data/data_source/general_expense_remote_data_source.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/material_expense_item_entity.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/entity/materials.dart';
import 'package:monkey_app/feature/expense/material_expense/domain/repo/material_repo.dart';

import '../../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../general_expense/domain/use_case/param/update_param.dart';

class MaterialExpenseImpl extends MaterialExpenseRepo {
  final MaterialExpenseRemoteDataSource remoteDataSource;

  MaterialExpenseImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MaterialExpenseItemEntity>> createMaterialExpense(
    param,
  ) async {
    try {
      var result = await remoteDataSource.createMaterialExpense(param);
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
  Future<Either<Failure, MaterialExpenseEntity>> fetchMaterialExpense(
    RequestParameters param,
  ) async {
    try {
      var result = await remoteDataSource.fetchMaterialExpense(param);
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
  Future<Either<Failure, MaterialExpenseItemEntity>> updateMaterialExpense(
    UpdateExpenseParam param,
  ) async {
    try {
      var result = await remoteDataSource.updateMaterialExpense(param);
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
  Future<Either<Failure, List<MaterialsEntity>>> fetchMaterials(
    RequestParameters param,
  )async {
    try {
      var result = await remoteDataSource.fetchMaterials(param);
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

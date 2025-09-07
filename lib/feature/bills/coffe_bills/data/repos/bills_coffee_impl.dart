import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/data_source/bills_coffee_data_source.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_all_layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import 'package:monkey_app/feature/bills/coffe_bills/param/create_bills_coffee_param.dart';
import 'package:monkey_app/feature/bills/main_bills/presentation/view/widget/param/fetch_bills_param.dart';

import '../../domain/entity/coffee_bills_page_entity.dart';

class BillsCoffeeImpl extends CoffeeBillsRepo {
  final BillsCoffeeDataSource billsCoffeeDataSource;

  BillsCoffeeImpl({required this.billsCoffeeDataSource});

  @override
  Future<Either<Failure, List<BillsCoffeeEntity>>> fetchActiveCoffeeBills(
    FetchBillsParam param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.fetchActiveBillsCoffee(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        print('❌ DioException: ${e.message}');
        print('❌ API Error: $e');
        return left(ServerFailure.fromDioError(e));
      } else {
        print('❌ Other Exception: $e');
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, BillsCoffeePageEntity>> fetchAllCoffeeBills(
    FetchBillsParam param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.fetchBillsCoffee(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        print('❌ DioException: ${e.message}');
        print('❌ API Error: $e');
        return left(ServerFailure.fromDioError(e));
      } else {
        print('❌ Other Exception: $e');
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, GetOneBillsCoffeeEntity>> getOneCoffeeBills(
    int id,
  ) async {
    try {
      var result = await billsCoffeeDataSource.getOneBillsCoffee(id);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        print('❌ DioException: ${e.message}');
        print('❌ API Error: $e');
        return left(ServerFailure.fromDioError(e));
      } else {
        print('❌ Other Exception: $e');
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> createCoffeeBills(
    CreateBillsPCoffeeParam param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.createBillsCoffee(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        print('❌ DioException: ${e.message}');
        print('❌ API Error: $e');
        return left(ServerFailure.fromDioError(e));
      } else {
        print('❌ Other Exception: $e');
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<LayersEntity>>> getLayerOne(
    FetchBillsParam param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.getLayerOne(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        print('❌ DioException: ${e.message}');
        print('❌ API Error: $e');
        return left(ServerFailure.fromDioError(e));
      } else {
        print('❌ Other Exception: $e');
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<LayersEntity>>> getLayerTow(
    FetchBillsParam param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.getLayerTow(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        print('❌ DioException: ${e.message}');
        print('❌ API Error: $e');
        return left(ServerFailure.fromDioError(e));
      } else {
        print('❌ Other Exception: $e');
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<GetAllLayerEntity>>> getAllLayers(
    FetchBillsParam param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.getAllLayers(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        print('❌ DioException: ${e.message}');
        print('❌ API Error: $e');
        return left(ServerFailure.fromDioError(e));
      } else {
        print('❌ Other Exception: $e');
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}

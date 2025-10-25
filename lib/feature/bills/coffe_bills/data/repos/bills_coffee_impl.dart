import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/utils/constans.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/data_source/bills_coffe_local_data_source.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/data_source/bills_coffee_data_source.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/hive_entity/layers_hive_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/data/model/mapper.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_all_layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/get_one_bills_coffee_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/entity/layers_entity.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/repo/coffee_bills_repo.dart';
import 'package:monkey_app/feature/bills/coffe_bills/domain/use_case/param/return_product_param.dart';
import 'package:monkey_app/feature/bills/coffe_bills/param/create_bills_coffee_param.dart';

import '../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../domain/entity/coffee_bills_page_entity.dart';

class BillsCoffeeImpl extends CoffeeBillsRepo {
  final BillsCoffeeDataSource billsCoffeeDataSource;
  final BillsCoffeeLocalDataSource billsCoffeeLocalDataSource;

  BillsCoffeeImpl({
    required this.billsCoffeeDataSource,
    required this.billsCoffeeLocalDataSource,
  });

  @override
  Future<Either<Failure, List<BillsCoffeeEntity>>> fetchActiveCoffeeBills(
    RequestParameters param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.fetchActiveBillsCoffee(param);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BillsCoffeePageEntity>> fetchAllCoffeeBills(
    RequestParameters param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.fetchBillsCoffee(param);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetOneBillsCoffeeEntity>> getOneCoffeeBills(
    int id,
  ) async {
    try {
      var result = await billsCoffeeDataSource.getOneBillsCoffee(id);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BillsCoffeeEntity>> createCoffeeBills(
    CreateBillsPCoffeeParam param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.createBillsCoffee(param);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LayersEntity>>> getLayerOne(
    RequestParameters  param,
  ) async {
    try {
      final box = Hive.box<LayersHiveEntity>(kSaveLayerOne);
      if (box.isNotEmpty) {
        final hiveData = await billsCoffeeLocalDataSource.fetchLayers();
        unawaited(billsCoffeeDataSource.getLayerOne(param));
        final data = hiveData.map((e) => e.toEntity()).toList();
        return right(data);
      }
      var result = await billsCoffeeDataSource.getLayerOne(param);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LayersEntity>>> getLayerTow(
    RequestParameters param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.getLayerTow(param);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetAllLayerEntity>>> getAllLayers(
    RequestParameters param,
  ) async {
    try {
      var result = await billsCoffeeDataSource.getAllLayers(param);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BillsCoffeeEntity>> returnProduct(
    ReturnProductsParam param,
  ) async {
    try {
      final result = await billsCoffeeDataSource.returnProducts(param);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}

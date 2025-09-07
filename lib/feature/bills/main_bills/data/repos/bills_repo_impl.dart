import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';

import '../../domain/entity/Bills_entity.dart';
import '../../domain/entity/bills_page_entity.dart';
import '../../domain/entity/get_one_bills_entity.dart';
import '../../domain/repo/bills_repo.dart';
import '../../presentation/view/widget/apply_discount_param.dart';
import '../../presentation/view/widget/param/close_bills_param.dart';
import '../../presentation/view/widget/param/create_bills_param.dart';
import '../../presentation/view/widget/param/fetch_bills_param.dart';
import '../data_source/bills_remote_data_source.dart';

class BillsRepoImpl extends BillsRepo {
  final BillsRemoteDataSource billsRemoteDataSource;

  BillsRepoImpl({required this.billsRemoteDataSource});

  @override
  Future<Either<Failure, BillsPageEntity>> fetchBills(
    FetchBillsParam param,
  ) async {
    try {
      var result = await billsRemoteDataSource.fetchBills(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        // if(e.response?.statusCode==404){
        //   return right([]);
        // }
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
  Future<Either<Failure, BillsEntity>> createBills(CreateBillsParam param) async {
    try {
      var result = await billsRemoteDataSource.createBills(param);
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
  Future<Either<Failure, dynamic>> applyDiscount(
    ApplyDiscountParams param,
  ) async {
    try {
      var result = await billsRemoteDataSource.applyDiscount(param);
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
  Future<Either<Failure, List<BillsEntity>>> fetchActiveBills(
    FetchBillsParam param,
  ) async {
    try {
      var result = await billsRemoteDataSource.fetchActiveBills(param);
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
  Future<Either<Failure, dynamic>> closeBills(CloseBillsParam param) async {
    try {
      var result = await billsRemoteDataSource.closeBills(param);
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
  Future<Either<Failure, GetOneBillsEntity>> getOneBills(num id) async {
    try {
      var result = await billsRemoteDataSource.getOneBills(id);
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

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:monkey_app/feature/home/domain/entity/home_entity.dart';
import 'package:monkey_app/feature/home/domain/repo/home_repo.dart';

import '../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';

class HomeRepoImpl extends HomeRepo{
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});
  @override
  Future<Either<Failure, HomeEntity>> fetchDashBoardData(FetchBillsParam param)async {
    try {
      final result = await homeRemoteDataSource.fetchDashBoardData(param);
      return right(result);
    } on Exception catch (e) {
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}
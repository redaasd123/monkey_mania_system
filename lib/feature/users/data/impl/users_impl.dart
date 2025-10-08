import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import 'package:monkey_app/feature/users/data/data_source/user_data_source.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';
import 'package:monkey_app/feature/users/domain/entity/user_entity.dart';
import 'package:monkey_app/feature/users/domain/repo/create_user_param.dart';
import 'package:monkey_app/feature/users/domain/repo/update_user_param.dart';
import 'package:monkey_app/feature/users/domain/repo/users_repo.dart';

class UsersRepoImpl extends UsersRepo {
  final UserRemoteDataSource userRemoteDataSource;

  UsersRepoImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, UserDataEntity>> createUsers(CreateUserParam param) async {
    try {
      final result = await userRemoteDataSource.createUser(param);
      return right(result);
    }on Exception catch (e) {
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure(errMessage: e.toString()));
      }
      // TODO
    }
  }


  @override
  Future<Either<Failure, UserEntity>> fetchUsers(FetchBillsParam param) async {
    try {
      final result = await userRemoteDataSource.fetchUsers(param);
      return right(result);
    } on Exception catch (e) {
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure(errMessage: e.toString()));
      }
      // TODO
    }
  }

  @override
  Future<Either<Failure, UserDataEntity>> updateUsers(UpdateUserParam param)async {
    try {
      final result = await userRemoteDataSource.updateUser(param);
      return right(result);
    }on Exception catch (e) {
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure(errMessage: e.toString()));
      }
      // TODO
    }
  }
}
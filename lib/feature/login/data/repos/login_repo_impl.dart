import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/feature/login/domain/repo/login_repo.dart';

import '../data_source/login_remote_data_source.dart';

class LoginRepoImpl extends LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepoImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, dynamic>> LoginUser({
    required String pass,
    required String phone,
  }) async {
    try {
      var result = await loginRemoteDataSource.LoginUser(
        pass: pass,
        phone: phone,
      );
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

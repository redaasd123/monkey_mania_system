import 'dart:async';

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
      final result = await loginRemoteDataSource.loginUser(
        pass: pass,
        phone: phone,
      );
      return right(result);
    } on TimeoutException {
      return left(
        ServerFailure(
          errMessage: '⏱ انتهت مهلة الاتصال بالخادم. حاول مرة أخرى.',
        ),
      );
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(
        ServerFailure(errMessage: '⚠️ خطأ غير معروف: ${e.toString()}'),
      );
    }
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/feature/login/data/model/login_model.dart';

import '../../../../core/helper/auth_helper.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> LoginUser({required String pass, required String phone});
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final Api api;

  LoginRemoteDataSourceImpl(this.api);

  @override
  Future<LoginModel> LoginUser({
    required String pass,
    required String phone,
  }) async {
    try {
      final response = await api
          .post(
            endPoint: 'token/obtain/',
            body: {'phone_number': phone, 'password': pass},
            token: null,
          )
          .timeout(const Duration(seconds: 10));

      final authModel = LoginModel.fromJson(response.data);

      await AuthHelper.saveTokens(
        branch: authModel.branch,
        accessToken: authModel.access,
        refreshToken: authModel.reFresh,
        username: authModel.username,
        role: authModel.role,
      );
      return authModel;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorData = e.response?.data;

        if (errorData is Map) {
          if (errorData['detail'] != null) {
            throw Exception(errorData['detail']);
          } else if (errorData['errors'] is Map &&
              errorData['errors']['detail'] != null) {
            throw Exception(errorData['errors']['detail']);
          } else if (errorData['message'] != null) {
            throw Exception(errorData['message']);
          } else {
            throw Exception('فشل في تسجيل الدخول. حاول مرة أخرى.');
          }
        } else {
          throw Exception('فشل في تسجيل الدخول. حاول مرة أخرى.');
        }
      } else {
        throw Exception('فشل في الاتصال بالسيرفر.');
      }
    }
  }
}

import 'dart:async';
import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/feature/login/data/model/login_model.dart';
import '../../../../core/helper/auth_helper.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> loginUser({required String pass, required String phone});
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final Api api;

  LoginRemoteDataSourceImpl(this.api);

  @override
  Future<LoginModel> loginUser({
    required String pass,
    required String phone,
  }) async {


      final response = await api
          .post(
        endPoint: 'token/obtain/',
        body: {'phone_number': phone, 'password': pass},
        token: null,
      )
          .timeout(const Duration(seconds: 15));

      final authModel = LoginModel.fromJson(response.data);


      await AuthHelper.saveTokens(
        branch: authModel.branch,
        accessToken: authModel.access,
        refreshToken: authModel.reFresh,
        username: authModel.username,
        role: authModel.role,
      );
      return authModel;
    }
  }


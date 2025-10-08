import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';
import 'package:monkey_app/core/utils/constans.dart';

import '../helper/intrecptor_helper.dart';

class Api {

  final Dio dio;

  Api({required this.dio}) {
    setupInterceptors(dio);
  }

  Future<dynamic> getUri(Uri uri) async {
    final response = await dio.getUri(uri);
    return response.data;
  }

  Future<dynamic> get({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    final headers = <String, String>{
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await dio.get(
        kBaseUrl + endPoint,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }

  Future<dynamic> post({
    required String endPoint,
    required dynamic body,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    Map<String, String> headers = {
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await dio.post(
        queryParameters: queryParameters,
        kBaseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put({
    required String endPoint,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await dio.put(
        kBaseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> patch({
    required String endPoint,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      var response = await dio.patch(
        kBaseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

}

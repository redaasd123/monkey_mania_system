import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:monkey_app/core/utils/constans.dart';

import '../../main.dart';
import '../helper/intrecptor_helper.dart';

class Api {
  final Dio dio;

  Api({required this.dio}) {
    setupInterceptors(dio);
  }

  /// ✅ Get current language (for Accept-Language header)
  String getCurrentLanguage() {
    return navigatorKey.currentContext?.locale.languageCode ?? 'en';
  }

  /// --------------------- GET ---------------------
  Future<dynamic> get({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    final headers = <String, String>{
      'Accept-Language': getCurrentLanguage(),
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await dio.get(
        kBaseUrl + endPoint,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  /// --------------------- POST ---------------------
  Future<dynamic> post({
    required String endPoint,
    required dynamic body,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    final headers = <String, String>{
      'Accept-Language': getCurrentLanguage(),
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.post(
        kBaseUrl + endPoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// --------------------- PUT ---------------------
  Future<dynamic> put({
    required String endPoint,
    required dynamic body,
    String? token,
  }) async {
    final headers = <String, String>{
      'Accept-Language': getCurrentLanguage(),
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.put(
        kBaseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// --------------------- PATCH ---------------------
  Future<dynamic> patch({
    required String endPoint,
    required dynamic body,
    String? token,
  }) async {
    final headers = <String, String>{
      'Accept-Language': getCurrentLanguage(),
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.patch(
        kBaseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}

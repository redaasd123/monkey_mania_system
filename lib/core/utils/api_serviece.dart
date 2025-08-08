import 'package:dio/dio.dart';
import 'package:monkey_app/core/errors/failure.dart';

import '../helper/intrecptor_helper.dart';
class Api {
  static final String _baseUrl = 'https://monkey-mania-production.up.railway.app/';
  final Dio dio;

  Api({required this.dio}) {
    setupInterceptors(dio); // ✅ فعلنا الإنترسبتور هنا
  }
  Future<dynamic> getUri(Uri uri) async {
    final response = await dio.getUri(uri);
    return response.data;
  }

  Future<dynamic> get({
  required String endPoint,
  String? token,
    Map<String,dynamic>?queryParameters
  }) async {
    final headers = <String, String>{
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      // 2️⃣ مرِّر الـ Headers إلى Dio عبر Options
      final response = await dio.get(
        _baseUrl + endPoint,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      print('✅ Response status: ${response.statusCode}');
      print('📦 Response data: ${response.data}');
      print('📦 Status: ${response.statusCode}');
      print('📦 Data  : ${response.data}');
      print('📩 Request sent to: $endPoint');
      print('📌 Query Params: $queryParameters');
      print('📥 Response: ${response.data}');
      return response.data; // 3️⃣ عند النجاح
    } on DioException catch (e) {
      print('❌ API Error: $e');
      throw ServerFailure.fromDioError(e);
    } catch (e, stackTrace) {
      print('❌ API Error: $e');
      print(stackTrace);
      rethrow;
  }}






  Future<dynamic> post({
    required String endPoint,
    required dynamic body,
     String? token,
  }) async {
    print("📦 Request Body: ${body.toString()}");
    Map<String, String> headers = {
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print('📤 Headers: ${headers}');
    try {
      var response = await dio.post(
        _baseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      print('🔴 REQUEST BODY: $body');
      print('🔴 ENDPOINT: $endPoint');
      print("🟢 Refresh Token Response: ${response.data}");
      return response;

    } catch (e) {
      print("❌ ERROR FROM API: $e");
      print('❌ Dio Error: $e');
      rethrow;
    }

  }




  Future<dynamic> put({
    required String endPoint, // ✅
    required dynamic body,
     String? token,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await dio.put(
        _baseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      print('🔴 REQUEST BODY: $body');
      print('🔴 ENDPOINT: $endPoint');
      return response;
    } catch (e) {
      print("❌ ERROR FROM API: $e");
      print('❌ Dio Error: $e');
      rethrow;
    }
  }

}
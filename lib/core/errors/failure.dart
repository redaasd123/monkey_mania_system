import 'dart:io';

import 'package:dio/dio.dart';

/// Abstract failure class
abstract class Failure {
  final String errMessage;

  Failure({required this.errMessage});
}

/// Server-specific failure implementation
class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});

  /// Handle all Dio errors safely
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: '⏱ Timeout: فشل الاتصال بالخادم.');

      case DioExceptionType.badResponse:
        final response = dioError.response;
        if (response != null) {
          return ServerFailure.fromResponse(response.statusCode, response.data);
        } else {
          return ServerFailure(errMessage: '📡 استجابة غير متوقعة من السيرفر.');
        }

      case DioExceptionType.cancel:
        return ServerFailure(errMessage: '❌ تم إلغاء الطلب.');

      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          return ServerFailure(errMessage: '📴 لا يوجد اتصال بالإنترنت.');
        } else {
          return ServerFailure(errMessage: '⚠️ خطأ غير معروف.');
        }

      default:
        return ServerFailure(errMessage: '⚠️ حدث خطأ غير متوقع.');
    }
  }

  /// Handle server response status codes
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    try {
      String? errorMessage;

      if (response is Map<String, dynamic>) {
        errorMessage = response['message'] ?? response['error'];

        if (errorMessage == null && response['errors'] is Map) {
          final errorsMap = response['errors'] as Map;
          for (final entry in errorsMap.entries) {
            final value = entry.value;
            if (value is List && value.isNotEmpty) {
              errorMessage = value.first.toString();
              break;
            } else if (value is String) {
              errorMessage = value;
              break;
            }
          }
        }
      }

      errorMessage ??= '⚠️ حدث خطأ غير متوقع. حاول لاحقًا.';

      switch (statusCode) {
        case 400:
        case 401:
        case 403:
          return ServerFailure(errMessage: errorMessage);
        case 404:
          return ServerFailure(
            errMessage: '🔍 لم يتم العثور على المورد المطلوب.',
          );
        case 500:
        case 502:
        case 503:
          return ServerFailure(errMessage: '🛠 خطأ من الخادم. حاول لاحقًا.');
        default:
          return ServerFailure(
            errMessage: '📄 خطأ برمز غير متوقع: $statusCode',
          );
      }
    } catch (e) {
      return ServerFailure(errMessage: '❗ فشل في فهم الاستجابة من الخادم.');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../main.dart';
import '../utils/app_router.dart';
import 'auth_helper.dart';

void setupInterceptors(Dio dio) {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await AuthHelper.getAccessToken();

        options.headers['Accept-Language'] =
            navigatorKey.currentContext?.locale.languageCode ?? 'en';

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        handler.next(options);
      },

      onError: (error, handler) async {
        final context = navigatorKey.currentContext;

        final currentToken = await AuthHelper.getAccessToken();
        if (currentToken == null || currentToken.isEmpty) {
          return handler.next(error);
        }

        if (error.response?.statusCode == 401) {
          final requestPath = error.requestOptions.path;

          void showSessionExpiredMessage(String msg) {
            if (context != null && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(msg),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          }

          if (requestPath.contains("token/refresh/")) {
            showSessionExpiredMessage("⏰ انتهت الجلسة، من فضلك سجل الدخول مرة أخرى");
            await AuthHelper.clearAuthData();
            AppRouter.router.go(AppRouter.kLoginView);
            return;
          }

          final newToken = await AuthHelper.refreshAccessToken();

          if (newToken != null && newToken.isNotEmpty) {
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';

            try {
              final clonedRequest = await dio.fetch(error.requestOptions);
              return handler.resolve(clonedRequest);
            } catch (_) {
              showSessionExpiredMessage("فشل في إعادة تنفيذ الطلب، حاول مرة أخرى");
            }
          } else {
            showSessionExpiredMessage("⏰ انتهت الجلسة، من فضلك سجل الدخول مرة أخرى");
            await AuthHelper.clearAuthData();
            AppRouter.router.go(AppRouter.kLoginView);
            return;
          }
        }

        if (error.type == DioErrorType.connectionError ||
            error.type == DioErrorType.connectionTimeout) {
          if (context != null && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("❌ فشل الاتصال بالخادم، تأكد من الإنترنت."),
              ),
            );
          }
        }

        handler.next(error);
      },
    ),
  );
}

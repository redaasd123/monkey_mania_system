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
        final token = AuthHelper.getAccessToken();

        options.headers['Accept-Language'] =
            navigatorKey.currentContext?.locale.languageCode ?? 'en';

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final requestPath = error.requestOptions.path;

          // دالة تعرض رسالة
          void showSessionExpiredMessage(String msg) {
            final context = navigatorKey.currentContext;
            if (context != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg)),
              );
            }
          }

          // ✅ لو refresh token نفسه خلص
          if (requestPath.contains("token/refresh/")) {
            showSessionExpiredMessage("⏰ انتهت الجلسة، من فضلك سجل الدخول مرة أخرى");
            await AuthHelper.clearAuthData();
            AppRouter.router.go(AppRouter.kLoginView);
            return;
          }

          // ✅ جرّب تعمل refresh
          final newToken = await AuthHelper.refreshAccessToken();

          if (newToken != null) {
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final clonedRequest = await dio.fetch(error.requestOptions);
            return handler.resolve(clonedRequest);
          } else {
            showSessionExpiredMessage("⏰ انتهت الجلسة، من فضلك سجل الدخول مرة أخرى");
            await AuthHelper.clearAuthData();
            AppRouter.router.go(AppRouter.kLoginView);
            return;
          }
        }

        return handler.next(error);
      },
    ),
  );
}

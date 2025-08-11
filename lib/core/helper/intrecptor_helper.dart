import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../main.dart';
import '../utils/app_router.dart';
import 'auth_helper.dart'; // يحتوي على getAccessToken() و refreshAccessToken()

void setupInterceptors(Dio dio) {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = AuthHelper.getAccessToken();

        // ✅ استخدام لغة الجهاز بشكل آمن
        options.headers['Accept-Language'] =
            navigatorKey.currentContext?.locale.languageCode ?? 'en';

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final newToken = await AuthHelper.refreshAccessToken();

          if (newToken != null) {
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final clonedRequest = await dio.fetch(error.requestOptions);
            return handler.resolve(clonedRequest);
          } else {
            await AuthHelper.clearAuthData();
            AppRouter.router.go(AppRouter.kLoginView);
          }
        }

        return handler.next(error);
      },
    ),
  );
}

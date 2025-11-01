import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../utils/api_serviece.dart';
import '../utils/constans.dart';
import '../utils/service_locator.dart';

class AuthKeys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const username = 'username';
  static const userId = 'user_id';
  static const role = 'role';
  static const branchId = 'branch';
  static const branchName = 'branchName';
}

class AuthHelper {
  static final Box _authBox = Hive.box(kAuthBox);

  static Future<void> saveTokens({
    required dynamic branchId,
    required int userId,
    required String branchName,
    required String? accessToken,
    required String? refreshToken,
    required String? username,
    required String? role,
  }) async {
    await _authBox.put(AuthKeys.userId, userId);
    await _authBox.put(AuthKeys.branchName, branchName);
    await _authBox.put(AuthKeys.accessToken, accessToken);
    await _authBox.put(AuthKeys.refreshToken, refreshToken);
    await _authBox.put(AuthKeys.username, username);
    await _authBox.put(AuthKeys.role, role);
    await _authBox.put(AuthKeys.branchId, branchId);
  }

  static String? getAccessToken() => _authBox.get(AuthKeys.accessToken);

  static String? getRefreshToken() => _authBox.get(AuthKeys.refreshToken);

  static String? getUsername() => _authBox.get(AuthKeys.username);

  static String? getRole() => _authBox.get(AuthKeys.role);

  static int getUserId() => _authBox.get(AuthKeys.userId);

  static dynamic getBranch() => _authBox.get(AuthKeys.branchId);

  static Future<void> clearAuthData() async => await _authBox.clear();

  static Future<void> logOut() async {
    try {
      final access = getAccessToken();
      final refresh = getRefreshToken();

      await Api(dio: Dio()).post(
        endPoint: 'token/blacklist/',
        body: {"refresh": refresh},
        token: access,
      );
    } catch (e, st) {
      debugPrint('Logout error: $e\n$st');
    } finally {
      await clearAuthData();
    }
  }

  static Future<String?> refreshAccessToken() async {
    final refreshToken = getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await getIt<Api>().post(
        endPoint: "token/refresh/",
        body: {'refresh': refreshToken},
        token: null,
      );

      final data = response.data;
      if (data == null || data['access'] == null || data['refresh'] == null) {
        return null;
      }

      await _authBox.put(AuthKeys.accessToken, data['access']);
      await _authBox.put(AuthKeys.refreshToken, data['refresh']);

      return data['access'];
    } catch (e, st) {
      debugPrint("❌ Failed to refresh token: $e\n$st");
      return null;
    }
  }
}

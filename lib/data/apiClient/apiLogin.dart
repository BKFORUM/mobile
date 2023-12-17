import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiClient extends GetConnect {
  Future<String> login(String email, String password) async {
    final preferences = await SharedPreferences.getInstance();
    final response = await post(
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.loginEmail,
      {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 201) {
      final accessToken = response.body['accessToken'] as String;
      final refreshToken = response.body['refreshToken'] as String;
      // print(token);
      preferences.setString('accessToken', accessToken);
      preferences.setString('refreshToken', refreshToken);
      preferences.setBool('isLoggedIn', true);
      return accessToken;
    } else {
      preferences.setBool('isLoggedIn', false);
      return('Đăng nhập thất bại '+(response.body['message'] ?? ''));
    }
  }
  Future<String> refreshLogin(String refreshToken) async {
    final preferences = await SharedPreferences.getInstance();
    final headers = {
      'Authorization': 'Bearer $refreshToken',
    };
    final response = await get(
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.refresh,
      headers: headers
    );
    if (response.statusCode == 200) {
      final accessToken = response.body['accessToken'] as String;
      final refreshToken = response.body['refreshToken'] as String;
      // print(token);
      preferences.setString('accessToken', accessToken);
      preferences.setString('refreshToken', refreshToken);
      preferences.setBool('isLoggedIn', true);
      return accessToken;
    } else {
      preferences.setBool('isLoggedIn', false);
      return('Đăng nhập thất bại');
    }
  }
}
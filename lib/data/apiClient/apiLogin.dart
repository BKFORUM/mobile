import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiClient extends GetConnect {
  Future<String> login(String email, String password) async {
    final response = await post(
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.loginEmail,
      {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 201) {
      final token = response.body['accessToken'] as String;
      final preferences = await SharedPreferences.getInstance();
      print(token);
      preferences.setString('accessToken', token);
      preferences.setString('email', email);
      preferences.setString('password', password);
      preferences.setBool('isLoggedIn', true);
      return token;
    } else {
      return('Đăng nhập thất bại');
    }
  }
}
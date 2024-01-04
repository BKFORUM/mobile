import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
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
      return('Đăng nhập thất bại');
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

  Future<bool> requestForget(String email) async {
    final response = await post(
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.forgot,
      {
        'email' : email
      }
    );
    if(response.statusCode == 201) return true;
      else return false;
  }

  Future<bool> resetPassword(String email, String token, String password) async {
    final response = await post(
        ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.resetPassword,
        {
          "email": email,
          "token": token,
          "password": password
        }
    );
    if(response.statusCode == 201) {
      Get.back();
      Get.snackbar("Thay đổi mật khẩu thành công", "Vui lòng đăng nhập lại",
        backgroundColor: Colors.green
      );
      return true;
    } else {
      print(response.body['message']);
      Get.snackbar("Thay đổi mật khẩu không thành công", response.body['message'],
      backgroundColor: Colors.red.shade400);
      return false;
    }
  }
}
import 'package:bkforum/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/api_endpoints.dart';
import '../models/profile_model.dart';

class ProfileApi extends GetConnect {
  Future<Profile> fetchProfile(String id) async {

    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response;
    if (id=='') {
      response = await get(
        ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.profile,
        headers: headers,
      );
    }else{
      response = await get(
        ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.user+'$id',
        headers: headers,
      );
    }

    if (response.statusCode == 200) {
      final jsonData = response.body;
      Profile profile =  Profile.fromJson(jsonData);
      if (id=='') {
        preferences.setString('id', profile.id.toString());
        preferences.setString('avatarUrl', profile.avatarUrl.toString());
      }
      return profile;
    } else {
      Get.snackbar('Lỗi', response.body['message'], backgroundColor: Colors.red);
      throw Exception('Failed to fetch profile ${response.statusCode}');
    }
  }

  Future<void> editProfile(Profile editedProfile, String? fileUrl) async {
    final preferences = await SharedPreferences.getInstance();
    String accessToken = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final url = ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.user+'${editedProfile.id}';
    final response = await put(url, {
      "fullName": editedProfile.fullName,
      "gender": editedProfile.gender,
      "dateOfBirth": editedProfile.dateOfBirth!.toIso8601String()+'Z',
      "phoneNumber": editedProfile.phoneNumber,
      "address": editedProfile.address,
      "avatarUrl": fileUrl
    }, headers: headers);
    if(response.isOk){
      Get.snackbar('Thành công', 'Đã chỉnh sửa thành công',
          backgroundColor: Colors.green);
      Get.offNamed(AppRoutes.pageSettingScreen);
    } else {
      Get.snackbar('Lỗi', response.body['message'] ?? '',
          backgroundColor: Colors.red.shade300);
    }
  }

  Future<void> changePassword(String newPassword, String email) async {
    final preferences = await SharedPreferences.getInstance();
    String accessToken = preferences.getString('accessToken') ?? '';
    String refreshToken = preferences.getString('refreshToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final url = ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.resetPassword;
    final response = await post(url, {
      "email" : email,
      "token" : refreshToken,
      "password": newPassword,
    }, headers: headers);
    if(response.isOk){
      Get.snackbar('Thành công', 'Đổi mật khẩu thành công',
          backgroundColor: Colors.green);
      Get.offNamed(AppRoutes.pageSettingScreen);
    } else {
      print(response.body['message']);
      Get.snackbar('Lỗi', response.body['message'] ?? '',
          backgroundColor: Colors.red.shade300);
    }
  }
}
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../core/utils/api_endpoints.dart';
import '../models/profile_model.dart';

class ProfileApi extends GetConnect {
  Future<Profile> fetchProfile() async {

    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await get(
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.profile,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = response.body;
      return Profile.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch profile ${response.statusCode}');
    }
  }
}
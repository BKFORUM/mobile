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
      throw Exception('Failed to fetch profile ${response.statusCode}');
    }
  }
}
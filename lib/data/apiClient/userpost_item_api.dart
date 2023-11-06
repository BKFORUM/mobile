import 'dart:convert';

import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/page_feed_screen/models/api_response.dart';
// import 'package:http/http.dart' as http;

class PostItemApiClient extends GetConnect {
  Future<dynamic> fetchData() async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
        ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.posts,
        headers: headers,
    );
    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(response.body);
      return apiResponse;
    } else {
      final code = response.statusCode;
      throw Exception('Failed to fetch data, status code $code');
    }
  }
}


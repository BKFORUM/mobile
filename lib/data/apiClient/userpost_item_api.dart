import 'dart:convert';

import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/page_feed_screen/models/api_response.dart';
// import 'package:http/http.dart' as http;

class PostItemApiClient extends GetConnect {
  Future<dynamic> fetchData(final String id, int take, int skip) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    // String email = preferences.getString('email') ?? '';

    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response;
    if (id=='') {
        response = await get(
        ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.posts+'?order=createdAt%3Adesc&take=${take}&skip=${skip}',
        headers: headers,
      );
    }else{
        response = await get(
        ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.forums+'/$id/posts?order=createdAt%3Adesc&take=${take}&skip=${skip}',
        headers: headers,
      );
    }
    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(response.body);
      return apiResponse;
    } else {
      throw Exception('Failed to fetch data, status code ${response.statusCode}');
    }
  }
}


import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_response.dart';
// import 'package:http/http.dart' as http;

class PostItemApiClient extends GetConnect {
  Future<dynamic> fetchData(final String id, int take, int skip) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response;
    if (id=='') {
        response = await get(
        ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.posts+'?order=createdAt%3Adesc&take=${take}&skip=${skip}&status=ACTIVE',
        headers: headers,
      );
    }else{
        response = await get(
        ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.forums+'/$id/posts?order=createdAt%3Adesc&take=${take}&skip=${skip}&status=ACTIVE',
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

  Future<bool> deletePost(String id) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response;
    response = await delete(
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.posts+'/$id',
      headers: headers,
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      print('Failed to delete post, status code ${response.statusCode} $id');
      return false;
    }
  }
}


import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:bkforum/data/models/data_prop/document.dart';
import 'package:bkforum/data/models/userpost_item_model.dart';
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
    if (id == '') {
      response = await get(
        ApiEndPoints.baseUrl +
            ApiEndPoints.authEndpoints.posts +
            '?order=createdAt%3Adesc&take=${take}&skip=${skip}&status=ACTIVE',
        headers: headers,
      );
    } else {
      response = await get(
        ApiEndPoints.baseUrl +
            ApiEndPoints.authEndpoints.forums +
            '/$id/posts?order=createdAt%3Adesc&take=${take}&skip=${skip}&status=ACTIVE',
        headers: headers,
      );
    }
    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(response.body);
      return apiResponse;
    } else {
      throw Exception(
          'Failed to fetch data, status code ${response.statusCode}');
    }
  }

  Future<dynamic> fetchUserPostData(final String id, int take, int skip) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response;
    response = await get(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.user +'$id/' +'posts'
          '?order=createdAt%3Adesc&take=${take}&skip=${skip}&status=ACTIVE',
      headers: headers,
    );
    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(response.body);
      return apiResponse;
    } else {
      throw Exception(
          'Failed to fetch posts, status code ${response.statusCode}');
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
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.posts + '/$id',
      headers: headers,
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      print('Failed to delete post, status code ${response.statusCode} $id');
      return false;
    }
  }

  Future<UserpostItemModel> fetchPostById(String id) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response;
    response = await get(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.posts+'/$id',
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = response.body;
      final post = UserpostItemModel(
        userCreate: Rx(data['user']['fullName']),
        userAvatar: Rx(data['user']['avatarUrl']),
        userCreateId: Rx('37dd59b2-9e9f-43f4-a5d8-76076b05a5d4'),
        forumModId: Rx(data['forum']['modId'] ?? ''),
        forumName: Rx(data['forum']['name'] ?? ''),
        postContent: Rx(data['content']),
        document: RxList<PostDocument>(data['documents'] != null
            ? List<PostDocument>.from(data['documents'].map((document) => PostDocument.fromJson(document)))
            : []),
        createdAt: Rx<DateTime>(DateTime.parse(data['createdAt'] ?? '2012-01-01')),
        likedAt: Rx<DateTime>(DateTime.parse(data['likedAt'] ?? '2012-01-01')),
        countLikes: Rx(data['_count']['likes'] ?? 0),
        countComments: Rx(data['_count']['comments'] ?? 0),
        id:  Rx(data['id'])
      );
      return post;
    } else {
      throw Exception(
          'Failed to fetch detail of post, status code ${response.statusCode}');
    }
  }
}

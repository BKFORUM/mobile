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
          'Failed to fetch data, ${response.body['error']}');
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
          ApiEndPoints.authEndpoints.user +
          '$id/' +
          'posts'
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
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.posts + '/$id',
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = response.body;
      final post = UserpostItemModel(
          userCreate: Rx(data['user']['fullName']),
          userAvatar: Rx(data['user']['avatarUrl']),
          userCreateId: Rx(data['user']['id']),
          forumModId: Rx(data['forum']['modId'] ?? ''),
          forumName: Rx(data['forum']['name'] ?? ''),
          postContent: Rx(data['content']),
          document: RxList(List<PostDocument>.from(
              data['documents'].map((x) => PostDocument.fromJson(x)))),
          createdAt:
              Rx<DateTime>(DateTime.parse(data['createdAt'] ?? '2012-01-01')),
          likedAt:
              Rx<DateTime>(DateTime.parse(data['likedAt'] ?? '2012-01-01')),
          countLikes: Rx(data['_count']['likes'] ?? 0),
          countComments: Rx(data['_count']['comments'] ?? 0),
          id: Rx(data['id']));
      List<String> fileUrls = [];
      for (var document in post.document!.value) {
        fileUrls.add(document.fileUrl ?? '');
      }
      post.listImages = RxList<String>(fileUrls);
      return post;
    } else {
      throw Exception(
          'Failed to fetch detail of post, status code ${response.statusCode}');
    }
  }
}

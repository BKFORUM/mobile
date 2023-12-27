import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:bkforum/data/models/data_prop/document.dart';
import 'package:bkforum/data/models/userpost_item_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_response.dart';

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
            '?order=createdAt%3Adesc&take=$take&skip=$skip&status=ACTIVE',
        headers: headers,
      );
    } else {
      response = await get(
        ApiEndPoints.baseUrl +
            ApiEndPoints.authEndpoints.forums +
            '/$id/posts?order=createdAt%3Adesc&take=$take&skip=$skip&status=ACTIVE',
        headers: headers,
      );
    }
    if (response.isOk) {
      final apiResponse = ApiResponse.fromJson(response.body);
      return apiResponse;
    } else {
      Get.snackbar('Lỗi khi tải bài viết', response.body['message'],
          backgroundColor: Colors.red.shade400);
      throw Exception('Failed to fetch data, ${response.body['error']}');
    }
  }

  Future<dynamic> getRequestPost(String forumId, int take, int skip) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.forums +
          '/$forumId/posts?order=createdAt%3Adesc&take=$take&skip=$skip&status=PENDING',
      headers: headers,
    );

    if (response.isOk) {
      final apiResponse = ApiResponse.fromJson(response.body);
      return apiResponse;
    } else {
      Get.snackbar('Lỗi khi tải bài viết', response.body['message'],
          backgroundColor: Colors.red.shade400);
      throw Exception('Failed to fetch data, ${response.body['error']}');
    }
  }

  Future<dynamic> fetchUserPostData(final String id, int take, int skip) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.user +
          '$id/' +
          'posts'
              '?order=createdAt%3Adesc&take=$take&skip=$skip&status=ACTIVE',
      headers: headers,
    );
    if (response.isOk) {
      final apiResponse = ApiResponse.fromJson(response.body);
      return apiResponse;
    } else {
      Get.snackbar('Lỗi khi tải bài viết', response.body['message'],
          backgroundColor: Colors.red.shade400);
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
    final response = await delete(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.posts + '/$id',
      headers: headers,
    );
    if (response.isOk) {
      return true;
    } else {
      Get.snackbar('Lỗi khi xóa bài viết', response.body['message'],
          backgroundColor: Colors.red.shade400);
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
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.posts + '/$id',
      headers: headers,
    );
    if (response.isOk) {
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
          status: Rx(data['status']),
          id: Rx(data['id']));
      List<String> fileUrls = [];
      for (var document in post.document!) {
        fileUrls.add(document.fileUrl ?? '');
      }
      post.listImages = RxList<String>(fileUrls);
      return post;
    } else {
      Get.snackbar('Lỗi khi tải bài viết', response.body['message'],
          backgroundColor: Colors.red.shade400);
      throw Exception(
          'Failed to fetch detail of post, status code ${response.statusCode}');
    }
  }

  acceptOrRejectRequestPost(UserpostItemModel post, bool isAccept) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await patch(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.posts + '/${post.id?.value}',
      {
        "status" : isAccept ? "ACTIVE" : "DELETED"
      },
      headers: headers,
    );
    if(response.isOk){
      isAccept
      ? Get.snackbar('Đã chấp nhận bài viết', 'Bài viết sẽ được hiển thị cho mọi người cùng xem',
          backgroundColor: Colors.green.shade400)
      : Get.snackbar('Đã từ chối bài viết', 'Bài viết sẽ xóa khỏi danh sách chờ',
          backgroundColor: Colors.amber.shade400);
    } else{
      Get.snackbar('Có vấn đề:', response.body['message'],
          backgroundColor: Colors.red.shade400);
    }
  }
}

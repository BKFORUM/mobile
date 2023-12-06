import 'dart:convert';

import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/comments_model.dart';
import '../models/reply.dart';
// import 'package:http/http.dart' as http;

class CommentsApiClient extends GetConnect {
  Future<dynamic> fetchData(String id, {int take = 10, int skip = 0}) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.posts +
          '/' +
          id +
          '/' +
          ApiEndPoints.authEndpoints.comments +
      '?take=$take&skip=$skip',
      headers: headers,
    );
    if (response.statusCode == 200) {
      List<CommentsModel> commentsList = [];
      for (dynamic commentData in response.body['data']) {
        final user = commentData['user'];
        final commentsModel = CommentsModel(
          userCreate: Rx<String>(user['fullName']),
          userAvatar: Rx<String>(user['avatarUrl']),
          content: Rx<String>(commentData['content']),
          countReplies: Rx<int>(commentData['_count']['replyComments']),
          id: Rx<String>(commentData['id']),
        );
        commentsList.add(commentsModel);
      }
      return commentsList;
    } else {
      final code = response.statusCode;
      throw Exception('Failed to fetch data, status code $code');
    }
  }

  Future<void> uploadComment(String id, String comment) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = {
      'content': comment,
    };
    final response = await post(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.posts +
          '/' + id + '/' +
          ApiEndPoints.authEndpoints.comments,
      jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 201) {
    } else {
      throw Exception(
          'Failed to upload comment, status code ${response.statusCode}');
    }
  }

  Future<void> uploadReply(String id, String content) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = {
      'content': content,
    };
    final response = await post(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.comments +
          '/' + id + '/' +
          ApiEndPoints.authEndpoints.replies,
      jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 201) {
    } else {
      throw Exception(
          'Failed to upload replies, status code ${response.statusCode}');
    }
  }

  Future<dynamic> fetchReplies(String id) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.comments +
          '/' + id + '/' +
          ApiEndPoints.authEndpoints.replies,
      headers: headers,
    );
    if (response.statusCode == 200) {
      List<ReplyModel> repliesList = [];
      for (dynamic replyData in response.body) {
        final user = replyData['user'];
        final replyModel = ReplyModel(
          userCreate: Rx<String>(user['fullName']),
          userAvatar: Rx<String>(user['avatarUrl']),
          commentId: Rx<String>(replyData['commentId']),
          content: Rx<String>(replyData['content']),
          id: Rx<String>(replyData['id']),
        );
        repliesList.add(replyModel);
      }
      return repliesList;
    } else {
      final code = response.statusCode;
      throw Exception('Failed to fetch data, status code $code');
    }
  }

  Future<bool> deleteComment(String id) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await delete(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.comments + '/' + id,
      headers: headers,
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      print('Failed to delete replies, status code ${response.statusCode}');
      return false;
    }
  }

  Future<bool> updateComment(String id, String content) async{
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final body = {
      'content': content,
    };
    final response = await put(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.comments + '/' + id,
      jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      print('Failed to update comment, status code ${response.statusCode}');
      return false;
    }
    return true;
  }
}

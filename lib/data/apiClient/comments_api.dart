import 'dart:convert';

import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/page_feed_screen/models/api_response.dart';
import '../../presentation/page_feed_screen/models/comments_model.dart';
// import 'package:http/http.dart' as http;

class CommentsApiClient extends GetConnect {
  Future<dynamic> fetchData(String id) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.posts+'/'+id+'/'+ApiEndPoints.authEndpoints.comments,
      headers: headers,
    );
    if (response.statusCode == 200) {
      List<CommentsModel> commentsList = [];
      for(dynamic commentData in response.body['data']){
        final user = commentData['user'];
        final commentsModel = CommentsModel(
          userCreate: Rx<String>(user['fullName']),
          userAvatar: Rx<String>(user['avatarUrl']),
          content: Rx<String>(commentData['content']),
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
  Future<void> uploadData(String id, String comment) async {
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
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.posts+'/'+id+'/'+ApiEndPoints.authEndpoints.comments,
      jsonEncode(body),
      headers: headers,
    );
    if(response.statusCode == 201){
    } else {
      throw Exception('Failed to fetch comment, status code ${response.statusCode}');
    }
  }
}


import 'dart:convert';

import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/page_feed_screen/models/api_response.dart';
import '../../presentation/page_feed_screen/models/data_prop/forum.dart';

class ForumListApiClient extends GetConnect {

  Future<List<Forum>> fetchForums(String userId) async {

    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    List<Forum> forums = [];
    final response = await get(
      ApiEndPoints.baseUrl+'users/$userId/'+ApiEndPoints.authEndpoints.forums,
      headers: headers,
    );
    if (response.statusCode == 200) {
      // final apiResponse = ApiResponse.fromJson(response.body);
      final jsonData = response.body;

      for (var res in jsonData) {
        final forum = Forum(
            id: res['id'],
            name: res['name'],
            modId: res['moderator']['id'],
            modName: res['moderator']['fullName'],
            avatarUrl: res['avatarUrl']
        );
        forums.add(forum);
      }

      return forums;
    } else {
      throw Exception('Failed to fetch forums, status code ${response.statusCode}');
    }
  }
}


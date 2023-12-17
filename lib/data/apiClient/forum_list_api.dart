import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:bkforum/data/models/data_prop/users.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';

import '../models/profile_model.dart';
import '../models/topic.dart';

class ForumListApiClient extends GetConnect {
  Future<List<Forum>> fetchForums(String userId) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    List<Forum> forums = [];
    final response = await get(
      ApiEndPoints.baseUrl +
          'users/$userId/' +
          ApiEndPoints.authEndpoints.forums,
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
            avatarUrl: res['avatarUrl']);
        forums.add(forum);
      }

      return forums;
    } else {
      throw Exception(
          'Failed to fetch forums, status code ${response.statusCode}');
    }
  }

  Future<Forum> forumDetail(String forumId) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.forums + '/$forumId',
      headers: headers,
    );
    if (response.statusCode == 200) {
      final res = response.body;
      final forum = Forum(
        id: res['id'],
        name: res['name'],
        modId: res['moderator']['id'],
        modName: res['moderator']['fullName'],
        topics: (res['topics'] as List<dynamic>?)
            ?.map((topicJson) => Topic.fromJson(topicJson))
            .toList(),
        users: (res['users'] as List<dynamic>?)
            ?.map((userJson) => User.fromJson(userJson['user']))
            .toList(),
        avatarUrl: res['avatarUrl'],
        yourStatus: res['yourStatus']
      );
      return forum;
    } else {
      throw Exception(
          'Failed to search forums, status code ${response.statusCode}');
    }
  }


  searchForums(String value) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    List<Forum> forums = [];
    final response = await get(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.forums +
          '?' +
          ApiEndPoints.authEndpoints.search +
          value,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonData = response.body['data'];

      for (var res in jsonData) {
        final forum = Forum(
            id: res['id'],
            name: res['name'],
            modId: res['moderator']['id'],
            modName: res['moderator']['fullName'],
            avatarUrl: res['avatarUrl']);
        forums.add(forum);
      }
      return forums;
    } else {
      throw Exception(
          'Failed to search forums, status code ${response.statusCode}');
    }
  }

  Future<List<Profile>> searchUsers(String value) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    List<Profile> users = [];
    final response = await get(
      ApiEndPoints.baseUrl +
          'users' +
          '?' +
          ApiEndPoints.authEndpoints.search +
          value,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = response.body['data'];
      for (var res in jsonData) {
        final user = Profile(
            id: res['id'],
            fullName: res['fullName'],
            dateOfBirth: DateTime.parse(res['dateOfBirth']),
            email: res['email'],
            address: res['address'],
            phoneNumber: res['phoneNumber'],
            gender: res['gender'],
            type: res['type'],
            avatarUrl: res['avatarUrl'],
            createdAt: DateTime.parse(res['createdAt']),
            updatedAt: DateTime.parse(res['updatedAt']),
            friendStatus: res['friendStatus']);
        users.add(user);
      }
      return users;
    } else {
      throw Exception(
          'Failed to search users, status code ${response.statusCode}');
    }
  }

  Future<bool> leaveForum(String forumId) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = ApiEndPoints.baseUrl +'forums/$forumId/exit';

    final response = await patch(url,{}, headers: headers);

    if (response.statusCode == 204) {
      print('Left the forum successfully');
      return true;
    } else {
      print('Failed to leave the forum. Error: ${response.statusCode}');
      return false;
    }
  }

  Future<bool> kickUserFromForum(String? userId, String forumId) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = ApiEndPoints.baseUrl +'forums/$forumId/requests';

    final response = await patch(url,{
      'userId' : userId,
      'status' : 'DELETED'
    }, headers: headers);

    if (response.statusCode == 204) {
      print('Kick user successfully');
      return true;
    } else {
      // print(userId);
      print('Failed to kick the user. Error: ${response.statusCode}');
      return false;
    }
  }
}

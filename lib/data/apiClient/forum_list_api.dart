import 'dart:convert';

import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:bkforum/data/models/data_prop/users.dart';
import 'package:bkforum/presentation/page_forumone_screen/page_forumone_screen.dart';
import 'package:flutter/material.dart';
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
      Get.snackbar('Lỗi', 'Error: ${response.body['message']}',
          backgroundColor: Colors.red.shade400);
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
          yourStatus: res['yourStatus']);
      return forum;
    } else {
      Get.snackbar(
          'Lỗi khi mở trang forum', 'Error: ${response.body['message']}',
          backgroundColor: Colors.red.shade400);
      throw Exception(
          'Failed to search forums, status code ${response.statusCode}');
    }
  }

  Future<List<Forum>> fetchForumOfUsers(String userId) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    List<Forum> forums = [];
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.user + '$userId/forums',
      headers: headers,
    );
    if (response.isOk) {
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
      Get.snackbar('Lỗi', response.body['message'],
          backgroundColor: Colors.red.shade400);
      return forums;
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
      Get.snackbar('Lỗi khi tìm kiếm', 'Error: ${response.body['message']}',
          backgroundColor: Colors.red.shade400);
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
      Get.snackbar('Lỗi khi tìm kiếm', 'Error: ${response.body['message']}',
          backgroundColor: Colors.red.shade400);
      throw Exception(
          'Failed to search users, status code ${response.statusCode}');
    }
  }

  Future<List<Profile>> searchNotInUsers(String value) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    List<Profile> users = [];
    final response = await get(
      ApiEndPoints.baseUrl +
          'users?order=fullName%3Aasc&forumId=$value&isInForum=false',
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
      Get.snackbar('Lỗi khi tìm kiếm', 'Error: ${response.body['message']}',
          backgroundColor: Colors.red.shade400);
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
    final url = ApiEndPoints.baseUrl + 'forums/$forumId/exit';

    final response = await patch(url, {}, headers: headers);

    if (response.statusCode == 204) {
      print('Left the forum successfully');
      return true;
    } else {
      print('Failed to leave the forum. Error: ${response.statusCode}');
      Get.snackbar(
          'Lỗi khi rời khỏi forum', 'Error: ${response.body['message']}',
          backgroundColor: Colors.red.shade400);
      return false;
    }
  }

  Future<bool> kickUserFromForum(String? userId, String forumId) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = ApiEndPoints.baseUrl + 'forums/$forumId/requests';

    final response = await patch(url, {'userId': userId, 'status': 'DELETED'},
        headers: headers);

    if (response.statusCode == 204) {
      print('Kick user successfully');
      return true;
    } else {
      Get.snackbar(
          'Lỗi khi xóa thành viên', 'Error: ${response.body['message']}',
          backgroundColor: Colors.red.shade400);
      return false;
    }
  }

  fetchTopics() async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = ApiEndPoints.baseUrl + 'topics';
    final response = await get(url, headers: headers);
    List<Topic> topics = [];
    if (response.statusCode == 200) {
      final jsonData = response.body;
      for (var res in jsonData) {
        final topic = Topic(id: res['id'], name: res['displayName']);
        topics.add(topic);
      }
      return topics;
    } else {
      Get.snackbar('Lỗi topic', 'Error: ${response.body['message']}',
          backgroundColor: Colors.red.shade400);
    }
  }

  Future<void> createForum(String forumName, RxList<Topic> topics, String? fileUrl) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    String profileId = preferences.getString('id') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.forums;
    final response = await post(
        url,
        {
          "name": forumName,
          "moderatorId": profileId,
          "type": "TOPIC",
          "topicIds": topics.map((topic) => topic.id).toList(),
          "avatarUrl": fileUrl,
        },
        headers: headers);
    if (response.isOk) {
      Get.snackbar(
          "Thành công", "Gửi yêu cầu thành công, vui lòng chờ admin kiểm duyệt",
          backgroundColor: Colors.green);
      Get.offNamed(
        AppRoutes.pageSettingScreen,
      );
    } else {
      Get.snackbar("Không thành công",
          "Tạo forum không thành công, ${response.body['message']}",
          backgroundColor: Colors.red.shade200);
      Get.offNamed(
        AppRoutes.pageSettingScreen,
      );
    }
  }


  Future<void> updateForum(String forumName, RxList<Topic> topics, String? fileUrl, String? forumId) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.forums+'/$forumId';
    final response = await put(
        url,
        {
          "name": forumName,
          "type": "TOPIC",
          "topicIds": topics.map((topic) => topic.id).toList(),
          "avatarUrl": fileUrl,
        },
        headers: headers);
    if (response.isOk) {
      Get.snackbar(
          "Thành công", "Lưu thành công",
          backgroundColor: Colors.green);
      Get.offNamed(
        AppRoutes.pageSettingScreen,
      );
    } else {
      Get.snackbar("Không thành công",
          "Thay đổi thông tin forum không thành công, ${response.body['message']}",
          backgroundColor: Colors.red.shade200);
      Get.offNamed(
        AppRoutes.pageSettingScreen,
      );
    }
  }

  Future<void> makeRequest(Forum forum) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final url = ApiEndPoints.baseUrl +
        ApiEndPoints.authEndpoints.forums +
        '/${forum.id}/requests';

    final response = await post(url, {}, headers: headers);
    if (response.isOk) {
      Get.snackbar(
          "Thành công", "Gửi yêu cầu thành công, vui lòng chờ mod kiểm duyệt",
          backgroundColor: Colors.green);
    } else {
      Get.snackbar("Không thành công",
          "Gửi yêu cầu không thành công, ${response.body['message']}",
          backgroundColor: Colors.red.shade200);
    }
  }

  Future<void> undoRequest(Forum forum) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    String profileId = preferences.getString('id') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = ApiEndPoints.baseUrl +
        ApiEndPoints.authEndpoints.forums +
        '/${forum.id}/requests';
    {
      final response = await patch(
          url, {"userId": profileId, "status": "DELETED"},
          headers: headers);
      if (response.isOk) {
        Get.snackbar("Thành công", "Hủy thành công",
            backgroundColor: Colors.green);
      } else {
        Get.snackbar(
            "Không thành công",
            "Hủy không thành công, ${response.body['message']}, "
                "${response.statusCode}",
            backgroundColor: Colors.red.shade200);
      }
    }
  }

  Future<void> addUsersToForum(RxList<Profile> addedUsers, Forum forum) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = ApiEndPoints.baseUrl +
        ApiEndPoints.authEndpoints.forums +
        '/${forum.id}/users';
    final List<String> userIds = addedUsers.map((user) => user.id).toList();
    final body = {
      'userIds': userIds,
    };
    final response = await post(url, jsonEncode(body), headers: headers);
    if (response.isOk) {
      Get.snackbar("Thành công", "Thêm thành viên thành công",
          backgroundColor: Colors.green);
      Get.off(() => PageForumoneScreen(),
          arguments: forum,
        transition: Transition.leftToRight
      );
    } else {
      Get.snackbar(
          "Không thành công",
          "Thêm thành viên không thành công, ${response.body['message']}, "
              "${response.statusCode}",
          backgroundColor: Colors.red.shade200);
    }
  }

  Future<void> acceptOrRejectRequestMember(Profile user, Forum forum, bool isAccepted) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await patch(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.forums + '/${forum.id}/requests',
      {
        "userId" : user.id,
        "status" : isAccepted ? "ACTIVE" : "DELETED"
      },
      headers: headers,
    );
    if(response.isOk){
      isAccepted
          ? Get.snackbar('Đã chấp nhận thành viên',
          '${user.fullName} sẽ có thể đăng bài trong forum',
          backgroundColor: Colors.green.shade400)
          : Get.snackbar('Đã từ chối ${user.fullName}',
          '${user.fullName} sẽ bị xóa khỏi danh sách chờ',
          backgroundColor: Colors.amber.shade400);
    } else{
      Get.snackbar('Có vấn đề:', response.body['message'],
          backgroundColor: Colors.red.shade400);
    }
  }

  Future<List<Profile>> getMemberRequest(String forumId) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };

    List<Profile> users = [];
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.forums
          + "/$forumId/requests",
      headers: headers,
    );

    if (response.isOk) {
      final jsonData = response.body;
      for (var res in jsonData) {
        final user = Profile(
            id: res['user']['id'],
            fullName: res['user']['fullName'],
            email: res['user']['email'],
            avatarUrl: res['user']['avatarUrl'],
        );
        users.add(user);
      }
      return users;
    } else {
      Get.snackbar('Lỗi khi tìm kiếm', 'Error: ${response.body['message']}',
          backgroundColor: Colors.red.shade400);
      throw Exception(
          'Failed to search users, status code ${response.statusCode}');
    }
  }


}

import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';
import 'package:bkforum/data/models/data_prop/users.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:bkforum/presentation/page_forumone_screen/page_forumone_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/api_endpoints.dart';
import '../models/data_prop/document.dart';
import '../models/data_prop/post_count.dart';

class EventApiClient extends GetConnect {
  fetchData({int take = 10, int skip = 0, String forumIds = ''}) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.events +
          '?take=$take&skip=$skip' +
          (forumIds != '' ? '&forumIds=$forumIds&type=FORUM' : '&type=GENERAL') +
          '&order=startAt%3Adesc',
      headers: headers,
    );
    if (response.isOk) {
      List<Event> eventsList = [];
      for (dynamic data in response.body['data']) {
        final eventsModel = Event(
          createdAt: Rx<DateTime>(DateTime.parse(data['createdAt'])),
          updatedAt: Rx<DateTime>(DateTime.parse(data['updatedAt'])),
          forumId: Rx<String>(data['forumId'] ?? ''),
          userId: Rx<String>(data['userId'] ?? ''),
          displayName: Rx<String>(data['displayName']),
          location: Rx<String>(data['location']),
          startAt: Rx<DateTime>(DateTime.parse(data['startAt'])),
          endAt: Rx<DateTime>(DateTime.parse(data['endAt'])),
          status: Rx<String>(data['status']),
          type: Rx<String>(data['type']),
          content: Rx<String>(data['content']),
          users: RxList<User>(data['users'] != null
              ? List<User>.from(
                  data['users'].map((user) => User.fromJson(user['user'])))
              : []),
          documents: RxList<PostDocument>(data['documents'] != null
              ? List<PostDocument>.from(data['documents']
                  .map((document) => PostDocument.fromJson(document)))
              : []),
          count: Rx<Count>(Count.fromJson(data['_count'])),
          isSubscriber: Rx<bool>(data['isSubscriber']),
          id: Rx<String>(data['id']),
        );
        eventsList.add(eventsModel);
      }
      return eventsList;
    } else {
      final code = response.statusCode;
      Get.snackbar('Lỗi', response.body['message'],
          backgroundColor: Colors.red.shade400);
      throw Exception('Failed to fetch event data, status code $code');
    }
  }

  Future<void> subscribe(Event event) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await patch(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.events +
          '/${event.id?.value}/subscribe',
      {},
      headers: headers,
    );
    if (response.isOk) {
      event.count?.value.users = event.count!.value.users! + 1;
    } else
      Get.snackbar('Lỗi', response.body['message'],
          backgroundColor: Colors.red.shade300);
  }

  Future<void> unSubscribe(Event event) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await patch(
      ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.events +
          '/${event.id?.value}/unsubscribe',
      {},
      headers: headers,
    );
    if (response.isOk) {
      event.count?.value.users = event.count!.value.users! - 1;
    } else
      Get.snackbar('Lỗi', response.body['message'],
          backgroundColor: Colors.red.shade300);
  }

  fetchEventById(String eventId) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.events + '/$eventId',
      headers: headers,
    );
    if (response.isOk) {
      final data = response.body;
      final eventsModel = Event(
        createdAt: Rx<DateTime>(DateTime.parse(data['createdAt'])),
        updatedAt: Rx<DateTime>(DateTime.parse(data['updatedAt'])),
        forumId: Rx<String>(data['forumId'] ?? ''),
        userId: Rx<String>(data['userId'] ?? ''),
        displayName: Rx<String>(data['displayName']),
        location: Rx<String>(data['location']),
        startAt: Rx<DateTime>(DateTime.parse(data['startAt'])),
        endAt: Rx<DateTime>(DateTime.parse(data['endAt'])),
        status: Rx<String>(data['status']),
        type: Rx<String>(data['type']),
        content: Rx<String>(data['content']),
        users: RxList<User>(data['users'] != null
            ? List<User>.from(
                data['users'].map((user) => User.fromJson(user['user'])))
            : []),
        documents: RxList<PostDocument>(data['documents'] != null
            ? List<PostDocument>.from(data['documents']
                .map((document) => PostDocument.fromJson(document)))
            : []),
        count: Rx<Count>(Count.fromJson(data['_count'])),
        isSubscriber: Rx<bool>(data['isSubscriber']),
        id: Rx<String>(data['id']),
      );
      return eventsModel;
    } else {
      Get.snackbar('Lỗi khi tìm kiếm sự kiện', response.body['message'],
          backgroundColor: Colors.red.shade400);
    }
  }

  Future<void> addEvent(Event newEvent) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    List<Map<String, dynamic>> documents = [];
    for (var document in newEvent.documents ?? []) {
      Map<String, dynamic> documentData = {
        "fileUrl": document.fileUrl,
        "fileName": document.fileName,
      };
      documents.add(documentData);
    }
    final response = await post(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.events,
      {
        "forumId": newEvent.forumId?.value,
        "type": "FORUM",
        "content": newEvent.content?.value,
        "documents": documents,
        "startAt": newEvent.startAt!.value.toIso8601String() + 'Z',
        "endAt": newEvent.endAt!.value.toIso8601String() + 'Z',
        "displayName": newEvent.displayName?.value,
        "location": newEvent.location?.value
      },
      headers: headers,
    );
    if (response.isOk) {
      final forum = Forum(id: newEvent.forumId!.value, name: '', modName: '');
      Get.off(() => PageForumoneScreen(),
          arguments: forum, transition: Transition.leftToRight
      );
      Get.snackbar('Thành công', 'Thêm sự kiện thành công',
          backgroundColor: Colors.green.shade300);
    } else
      Get.snackbar('Lỗi', response.body['message'],
          backgroundColor: Colors.red.shade300);
  }
}

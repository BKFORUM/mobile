import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/users.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/api_endpoints.dart';
import '../models/data_prop/document.dart';
import '../models/data_prop/post_count.dart';

class EventApiClient extends GetConnect{
  fetchData({int take = 10, int skip = 0, String forumIds = ''}) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.events
          + '?take=$take&skip=$skip'
          + (forumIds != '' ? '&forumIds=$forumIds' : '')
          +'&order=startAt%3Adesc',
      headers: headers,
    );
    if (response.statusCode == 200) {
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
          users: RxList<User>(data['users'] != null ? List<User>.from(data['users'].map((user) => User.fromJson(user['user']))) : []),
          documents: RxList<PostDocument>(data['documents'] != null
              ? List<PostDocument>.from(data['documents'].map((document) => PostDocument.fromJson(document)))
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
      throw Exception('Failed to fetch event data, status code $code');
    }
  }

}
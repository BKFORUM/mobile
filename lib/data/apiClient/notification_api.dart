import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/notification_model.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/api_endpoints.dart';

class NotificationApiClient {
  Future<List<NotificationModel>> fetchNotifications(int take, int skip) async {

    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';

    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await GetConnect().get(
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.notifications+'?take=${take}&skip=${skip}',
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = response.body;
      final List<dynamic> data = jsonData['data'];
      // print(data[0]['sender']);
      List<NotificationModel> notifications = [];
      for (var item in data) {
        NotificationModel notification = NotificationModel(
          id: Rx(item['id']),
          content: Rx(item['content']),
          modelId: Rx(item['modelId']),
          modelName: Rx(item['modelName']),
          userId: Rx(item['userId']),
          senderId: Rx(item['senderId']),
          readAt: Rx(item['readAt'] ?? ''),
          createdAt: Rx(item['createAt'] ?? ''),
          updatedAt: Rx(item['updateAt'] ?? ''),
          // sender: Rx(item['sender'])
        );
        Sender sender = Sender(
          id: Rx(item['sender']['id']),
          createdAt: Rx(item['sender']['createdAt']),
          updatedAt: Rx(item['sender']['updatedAt']),
          fullName: Rx(item['sender']['fullName']),
          email: Rx(item['sender']['email']),
          dateOfBirth: Rx(item['sender']['dateOfBirth']),
          gender: Rx(item['sender']['gender']),
          phoneNumber: Rx(item['sender']?['phoneNumber'] ?? ''),
          address: Rx(item['sender']['address'] ?? ''),
          password: Rx(item['sender']['password']),
          refreshToken: Rx(item['sender']['refreshToken']),
          avatarUrl: Rx(item['sender']['avatarUrl'] ?? ImageConstant.imageNullAvatar),
          type: Rx(item['sender']['type']),
          facultyId: Rx(item['sender']['facultyId']),
        );
        notification.sender = Rx(sender);
        notifications.add(notification);
      }
      return notifications;
    } else {
      throw Exception('Failed to fetch notifications ${response.statusCode}');
    }
  }
}


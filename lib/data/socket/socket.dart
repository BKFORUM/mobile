import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/notification.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../models/data_prop/users.dart';

class SocketIO {
  static late IO.Socket socket;
  static late List<User> listFriendOnline = <User>[].obs;

  void initSocket() async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    Map<String, dynamic> extraHeaders = {
      'token': token,
    };
    socket = IO.io(
        "ws://52.139.152.154",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setAuth(extraHeaders)
            .build());
    socket.onConnect((_) {
      print('Connect socket');
    });
    socket.onConnectError((data) => print(data));
    socket.emit("onGetOnlineFriends", {});
    socket.on("onGetOnlineFriends", (data) {
      for (dynamic user in data) {
        listFriendOnline.add(User.fromJson(user));
      }
    });
    socket.on("onFriendOffline", (data) {
      User user = User.fromJson(data);
      listFriendOnline.removeWhere((element) => element.id == user.id);
    });
    socket.on("onFriendOnline", (data) {
      User user = User.fromJson(data);
      listFriendOnline.add(user);
    });

    socket.on("onLikeCreated", (data) {
      Notifications noti = Notifications.fromJson(data);
      showSnackBar(noti);
    });

    socket.on("onCommentCreated", (data) {
      Notifications noti = Notifications.fromJson(data);
      showSnackBar(noti);
    });

    socket.on("onPostRequestApproved", (data) {
      Notifications noti = Notifications.fromJson(data);
      showSnackBar(noti);
    });

    socket.on("onPostRequestCreated", (data) {
      Notifications noti = Notifications.fromJson(data);
      showSnackBar(noti);
    });

    socket.on("onRequestForumApproved", (data) {
      Notifications noti = Notifications.fromJson(data);
      showSnackBar(noti);
    });

    socket.on("onRequestForumCreated", (data) {
      Notifications noti = Notifications.fromJson(data);
      showSnackBar(noti);
    });

    socket.on("onFriendRequestApproved", (data) {
      Notifications noti = Notifications.fromJson(data);
      showSnackBar(noti);
    });

    socket.on('onFriendRequestCreated', (data) {
      Notifications noti = Notifications.fromJson(data);
      showSnackBar(noti);
    });

    socket.on("onUpcomingEvent", (data) {
      Notifications noti = Notifications.fromJson(data);
      showSnackBar(noti);
    });
  }

  void emitEvent(String event, dynamic objects) {
    socket.emit(event, objects);
  }

  void addCallBack(String event, callback(dynamic data)) {
    socket.on(event, (data) => callback(data));
  }

  void deleteCallBack(String event, callback(dynamic data)) {
    socket.off(event, (data) => callback(data));
  }

  void showSnackBar(Notifications noti) {
    String temp =
        noti.sender!.fullName.toString() + " " + noti.content.toString();
    Get.snackbar(
      "Thông báo",
      temp,
      icon: Icon(Icons.notifications_active_rounded),
      onTap: (snack) {
        Get.toNamed(
          AppRoutes.pageNotificationScreen,
        );
      },
    );
  }
}

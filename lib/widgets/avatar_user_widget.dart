import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/socket/socket.dart';
import 'package:flutter/material.dart';

import '../data/models/data_prop/users.dart';

// ignore: must_be_immutable
class AvatarUserWidget extends StatefulWidget {
  User user;
  AvatarUserWidget(this.user);

  bool checkUserOnline() {
    return SocketIO.listFriendOnline
        .map((e) => e.id.toString())
        .toList()
        .contains(user.id.toString());
  }

  @override
  AvatarUserState createState() =>
      AvatarUserState(user.avatarUrl.toString(), checkUserOnline());
}

class AvatarUserState extends State<AvatarUserWidget> {
  String imageUrl;
  bool isOnline;
  AvatarUserState(this.imageUrl, this.isOnline);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 56.adaptSize,
        height: 56.adaptSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.adaptSize),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl),
          ),
        ),
        child: isOnline
            ? Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              )
            : SizedBox());
  }
}

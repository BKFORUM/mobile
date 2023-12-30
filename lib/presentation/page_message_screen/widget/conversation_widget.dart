import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:bkforum/data/models/data_prop/users.dart';
import 'package:bkforum/main.dart';
import 'package:bkforum/widgets/avatar_user_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConversationWidget extends StatefulWidget {
  Conversation conversation;
  ConversationWidget({required this.conversation});

  @override
  ConversationState createState() =>
      ConversationState(conversation: conversation);
}

class ConversationState extends State<ConversationWidget> {
  Conversation conversation;
  ConversationState({required this.conversation});

  String compactMessage(String? a, int length) {
    String temp = a ?? '';
    if (temp.length > length) {
      String rs = temp.substring(0, length) + "...";
      return rs;
    }
    return temp;
  }

  String showDateTime(String? dateString) {
    if (dateString == null) {
      return '';
    } else {
      DateTime dateTime = ConvertStringToDataTime(dateString);
      DateTime currentDateTime = DateTime.now();
      Duration difference = currentDateTime.difference(dateTime);
      return formatTimeDifference(difference);
    }
  }

  void goToMessageDetail() {
    Get.toNamed(AppRoutes.pageMessageDetailScreen, arguments: conversation);
  }

  @override
  Widget build(BuildContext context) {
    bool isUserChat = conversation.type.toString() == "CHAT";
    User user = User();
    if(isUserChat){
      if(conversation.users?[0].userId.toString() == myId){
        user = conversation.users?[1].user ?? User();
      } else {
        user = conversation.users?[0].user ?? User();
      }
    }
    return GestureDetector(
      onTap: goToMessageDetail,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            13.adaptSize, 0.adaptSize, 0.adaptSize, 0.adaptSize),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20.adaptSize),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: isUserChat
                    ? AvatarUserWidget(user)
                    : Container(
                        width: 56.adaptSize,
                        height: 56.adaptSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45.adaptSize),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(conversation.avatarUrl.toString()),
                          ),
                        ),
                      )),
            SizedBox(width: 10),
            Container(
              // frame193Hs9 (64:377)
              margin: EdgeInsets.fromLTRB(
                  0.adaptSize, 0.adaptSize, 0.adaptSize, 1.adaptSize),
              padding: EdgeInsets.fromLTRB(
                  0.adaptSize, 20.5.adaptSize, 0.adaptSize, 30.5.adaptSize),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0.adaptSize, 0.adaptSize, 0.adaptSize, 8.adaptSize),
                    child: Text(
                      conversation.displayName.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: conversation.isRead
                            ? FontWeight.w200
                            : FontWeight.w600,
                        height: 1.2175,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // frame192URq (64:379)
                    margin: EdgeInsets.fromLTRB(
                        0.adaptSize, 0.adaptSize, 44.adaptSize, 0.adaptSize),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0.adaptSize, 0.adaptSize,
                              25.adaptSize, 0.adaptSize),
                          child: Text(
                            compactMessage(
                                conversation.lastMessage?.content, 15),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: conversation.isRead
                                  ? FontWeight.w200
                                  : FontWeight.w600,
                              height: 1.2125,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Text(
                          showDateTime(conversation.lastMessage?.updatedAt),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: conversation.isRead
                                ? FontWeight.w200
                                : FontWeight.w600,
                            height: 1.2125,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

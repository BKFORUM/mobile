import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:bkforum/presentation/page_notification_screen/page_notification_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageWidget extends StatefulWidget {
  Message msg;
  MessageWidget(this.msg);

  @override
  MessageState createState() => MessageState(msg);
}

class MessageState extends State<MessageWidget> {
  Message msg;
  bool isCollapse = false;
  MessageState(this.msg);

  void clickAction() {
    isCollapse = !isCollapse;
    print(isCollapse);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: clickAction,
        child: Column(
          children: [
            if (this.isCollapse)
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: 300.adaptSize, minHeight: 40.adaptSize),
                child: Container(
                  margin: EdgeInsets.only(right: 10, top: 0, bottom: 0),
                  padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Color(0xff0001cb),
                      borderRadius:
                          BorderRadius.all(Radius.circular(10.adaptSize))),
                  child: Text(
                    msg.updatedAt.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 2,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 300.adaptSize, minHeight: 40.adaptSize),
              child: Container(
                margin: EdgeInsets.only(right: 10, top: 0, bottom: 0),
                padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Color(0xff0001cb),
                    borderRadius:
                        BorderRadius.all(Radius.circular(10.adaptSize))),
                child: Text(
                  msg.content.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 2,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

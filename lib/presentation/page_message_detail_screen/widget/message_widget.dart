import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
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
  MessageState(this.msg);

  @override
  Widget build(BuildContext context) {
    if (msg.type.toString() != 'TEXT') {
      return Container(
        margin: EdgeInsets.fromLTRB(
            0.adaptSize, 0.adaptSize, 8.adaptSize, 1.adaptSize),
        width: 100.adaptSize,
        height: 150.adaptSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.adaptSize),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(msg.content.toString()),
          ),
        ),
      );
    }
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: 300.adaptSize, minHeight: 40.adaptSize),
      child: Container(
        margin: EdgeInsets.only(right: 10, top: 0, bottom: 0),
        padding: EdgeInsets.only(top: 0, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Color(0xff0001cb),
            borderRadius: BorderRadius.all(Radius.circular(10.adaptSize))),
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
    );
  }
}

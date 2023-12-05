import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';

class MessageSendingWidget extends StatefulWidget {
  @override
  MessageSendingState createState() => MessageSendingState();
  
}

class MessageSendingState extends State<MessageSendingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // frameyiB (94:680)
      padding: EdgeInsets.fromLTRB(
          279.adaptSize, 4.adaptSize, 14.adaptSize, 4.adaptSize),
      width: double.infinity,
      height: 38.adaptSize,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Container(
        // frame210vNX (94:681)
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff0001cb),
          borderRadius: BorderRadius.circular(20.adaptSize),
        ),
        child: Center(
          child: Text(
            'Chưa ớ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.2125,
              color: Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }
}

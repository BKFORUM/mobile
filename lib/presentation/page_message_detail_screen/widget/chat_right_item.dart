import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget ChatRightItem(Message msg) {
  return Container(
    padding: EdgeInsets.only(
        top: 10.adaptSize,
        left: 15.adaptSize,
        right: 15.adaptSize,
        bottom: 10.adaptSize),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: 300.adaptSize, minHeight: 40.adaptSize),
          child: Container(
            margin: EdgeInsets.only(right:10, top: 0, bottom: 0),
            padding: EdgeInsets.only(top: 0, left: 10, right: 10),
            decoration: BoxDecoration(
                color: Color(0xff0001cb),
                borderRadius: BorderRadius.all(Radius.circular(10.adaptSize))),
            child: Text(
              msg.content.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 2,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

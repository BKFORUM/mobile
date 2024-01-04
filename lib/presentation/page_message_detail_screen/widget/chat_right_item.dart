import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/message_widget.dart';
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
        MessageWidget(msg)
      ],
    ),
  );
}
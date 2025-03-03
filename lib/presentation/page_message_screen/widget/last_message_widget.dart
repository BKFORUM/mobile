import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LastMessageWidget extends StatefulWidget {
  String content;
  LastMessageWidget({required this.content});
  @override
  LastMessageState createState() => LastMessageState(content: content);
}

class LastMessageState extends State<LastMessageWidget> {
  String content;

  LastMessageState({required this.content});

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

  @override
  Widget build(BuildContext context) {
    return Container(
      // frame192URq (64:379)
      margin: EdgeInsets.fromLTRB(
          0.adaptSize, 0.adaptSize, 44.adaptSize, 0.adaptSize),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            // helloworldQaP (64:385)
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  0.adaptSize, 0.adaptSize, 25.adaptSize, 0.adaptSize),
              child: Text(
                compactMessage(this.content, 15),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.2125,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          // Center(
          //   // am4Q3 (64:386)
          //   child: Text(
          //     showDateTime(conversation.lastMessage?.updatedAt),
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w100,
          //       height: 1.2125,
          //       color: Color(0xff000000),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

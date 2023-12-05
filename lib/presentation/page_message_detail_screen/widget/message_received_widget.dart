import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';

class MessageReceivedWidget extends StatefulWidget {
  @override
  MessageState createState() => MessageState();
}

class MessageState extends State<MessageReceivedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          14.adaptSize, 7.adaptSize, 123.adaptSize, 7.5.adaptSize),
      width: double.infinity,
      height: 62.adaptSize,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.adaptSize),
          bottomRight: Radius.circular(10.adaptSize),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // ellipse3y7h (97:716)
            margin: EdgeInsets.fromLTRB(
                0.adaptSize, 0.5.adaptSize, 15.adaptSize, 0.adaptSize),
            width: 36.adaptSize,
            height: 36.adaptSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.adaptSize),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/13282/13282718.png'),
              ),
            ),
          ),
          Container(
            // frame211g27 (97:717)
            width: 172.adaptSize,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // namanhRVV (97:718)
                  margin: EdgeInsets.fromLTRB(
                      0.adaptSize, 0.adaptSize, 0.adaptSize, 4.5.adaptSize),
                  child: Text(
                    'Nam Anh',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      height: 1.2125,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  // frame2098Pu (97:719)
                  width: double.infinity,
                  height: 30.adaptSize,
                  decoration: BoxDecoration(
                    color: Color(0xffb0b0b0),
                    borderRadius: BorderRadius.circular(20.adaptSize),
                  ),
                  child: Center(
                    child: Text(
                      'làm bài tập chưa hưng',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.2125,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

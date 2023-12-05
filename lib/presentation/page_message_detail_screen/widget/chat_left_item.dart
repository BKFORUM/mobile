import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget ChatLeftItem(Message msg) {
  return Container(
    padding: EdgeInsets.only(
        top: 10.adaptSize,
        left: 15.adaptSize,
        right: 15.adaptSize,
        bottom: 10.adaptSize),
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.adaptSize),
        bottomRight: Radius.circular(10.adaptSize),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(
              0.adaptSize, 0.5.adaptSize, 15.adaptSize, 0.adaptSize),
          width: 30.adaptSize,
          height: 30.adaptSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.adaptSize),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                msg.author?.avatarUrl ?? DEFAULT_URL_AVATAR_CONVERSATION
              ),
            ),
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  // namanhRVV (97:718)
                  margin: EdgeInsets.fromLTRB(
                      0.adaptSize, 0.adaptSize, 0.adaptSize, 4.5.adaptSize),
                  child: Text(
                    msg.author?.fullName ?? '',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      height: 1.2125,
                      color: Color(0xff000000),
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
                      fontWeight: FontWeight.w400,
                      height: 2,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

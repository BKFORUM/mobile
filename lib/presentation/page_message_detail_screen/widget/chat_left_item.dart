import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/message_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatLeftItemWidget extends StatefulWidget {
  Message msg;
  ChatLeftItemWidget(this.msg);
  @override
  ChatLeftItemState createState() => ChatLeftItemState(msg);
}

class ChatLeftItemState extends State<ChatLeftItemWidget> {
  Message msg;
  bool isShowTime = false;
  ChatLeftItemState(this.msg);

  void clickShowTime() {
    this.isShowTime = !this.isShowTime;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (this.isShowTime)
            Container(
              child: Text(
                formatDateTime(msg.updatedAt.toString()),
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ),
          Row(
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
                    image: NetworkImage(msg.author?.avatarUrl ??
                        DEFAULT_URL_AVATAR_CONVERSATION),
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
                        msg.author?.displayName ?? (msg.author?.fullName ?? ''),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          height: 1.2125,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        clickShowTime();
                        setState(() {});
                      },
                      child: MessageWidget(msg),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

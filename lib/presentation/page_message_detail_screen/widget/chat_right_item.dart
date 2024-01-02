import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/message.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/message_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatRightItemWidget extends StatefulWidget {
  Message msg;
  ChatRightItemWidget(this.msg);
  @override
  ChatRightItemState createState() => ChatRightItemState(msg);
}

class ChatRightItemState extends State<ChatRightItemWidget> {
  Message msg;
  bool isShowTime = false;
  ChatRightItemState(this.msg);

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
                style: TextStyle(fontSize: 12),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        clickShowTime();
                        setState(() {});
                      },
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: 300.adaptSize, minHeight: 40.adaptSize),
                        child: Container(
                          margin: EdgeInsets.only(right: 10, top: 0, bottom: 0),
                          padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Color(0xff0001cb),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.adaptSize))),
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

import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';

class ButtonAddFriendWidget extends StatefulWidget {
  @override
  _ButtonAddFriendState createState() => _ButtonAddFriendState();
}

class _ButtonAddFriendState extends State<ButtonAddFriendWidget> {
  bool isClicked = false;
  // ignore: non_constant_identifier_names
  void ClickButton() {
    setState(() {
      this.isClicked = !this.isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 30.adaptSize,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: !isClicked ? Color(0xff0001cb) : Color(0xffb0b0b0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // <-- Radius
            ),
          ),
          onPressed: () {
            ClickButton();
          },
          child: !this.isClicked
              ? Text(
                  'Kết bạn',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1.2125,
                    color: Color(0xfffafafa),
                  ),
                )
              : Text(
                  'Đã gửi lời mời',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1.2125,
                    color: Color(0xff000000),
                  ),
                )),
    );
  }
}

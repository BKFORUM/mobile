import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_friend_screen/widget/button_add_friend_widget.dart';
import 'package:flutter/material.dart';

class ComponentButtonMyFriendsWidget extends StatefulWidget {
  @override
  ComponentButtonMyFriendsState createState() => ComponentButtonMyFriendsState();
}

class ComponentButtonMyFriendsState extends State<ComponentButtonMyFriendsWidget> {
  bool isClickedAccept = false;
  // ignore: non_constant_identifier_names
  void ClickButtonAccept() {
    setState(() {
      this.isClickedAccept = !this.isClickedAccept;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: 30.adaptSize,
        child: 
        !this.isClickedAccept?
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                            0.adaptSize, 0.adaptSize, 9.adaptSize, 0.adaptSize),
              height: double.infinity,
              width: 120.adaptSize,
              child: ElevatedButton(
                
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0001cb),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    ClickButtonAccept();
                  },
                  child: Text(
                    'Chấp nhận',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 1.2125,
                      color: Color(0xfffafafa),
                    ),
                  )),
            ),
            Container(
              height: double.infinity,
              width: 120.adaptSize,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffb0b0b0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    ClickButtonAccept();
                  },
                  child: Text(
                    'Hủy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 1.2125,
                      color:  Color(0xff000000),
                    ),
                  )),
            ),
          ],
        ):
        ButtonAddFriendWidget()
        );
  }
}

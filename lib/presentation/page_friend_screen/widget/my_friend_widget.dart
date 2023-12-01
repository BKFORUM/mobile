import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/friend_model.dart';
import 'package:bkforum/presentation/page_friend_screen/widget/componet_button_my_friend_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyFriendsWidget extends StatelessWidget {
  MyFriendsWidget(this.myFriends, {Key? key}) : super(key: key);
  MyFriendModel myFriends;

  @override
  Widget build(BuildContext context) {
    return Container(
      //frame160fe3 (1:120)
      margin: EdgeInsets.fromLTRB(
          0.adaptSize, 0.adaptSize, 0.adaptSize, 10.adaptSize),
      padding: EdgeInsets.fromLTRB(
          15.adaptSize, 5.adaptSize, 5.adaptSize, 17.5.adaptSize),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(20.adaptSize),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Container(
            // ellipse4aW7 (1:121)
            margin: EdgeInsets.fromLTRB(
                0.adaptSize, 0.adaptSize, 22.adaptSize, 0.adaptSize),
            width: 90.adaptSize,
            height: 90.adaptSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45.adaptSize),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  myFriends.avatarUrl.toString()
                ),
              ),
            ),
          ),
          Container(
            // autogroupygq9WPm (YEE1GnTbbenp9xtdYZYGq9)
            margin: EdgeInsets.fromLTRB(
                0.adaptSize, 6.adaptSize, 0.adaptSize, 0.adaptSize),
            width: 250.adaptSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // trngquangkhangSoD (1:122)
                  margin: EdgeInsets.fromLTRB(
                      0.adaptSize, 0.adaptSize, 0.adaptSize, 10.adaptSize),
                  child: Text(
                    myFriends.fullName.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.2175,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                ComponentButtonMyFriendsWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

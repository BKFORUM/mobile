import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_friends_screen/model/friends_request_model.dart';
import 'package:bkforum/presentation/page_friends_screen/model/my_friend_model.dart';
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
                    "https://scontent.fhan14-2.fna.fbcdn.net/v/t39.30808-6/281326527_1704236456576162_5423355577385678617_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_ohc=-HuR_P88qrMAX9eBGyO&_nc_ht=scontent.fhan14-2.fna&oh=00_AfDU5F8Ap1W-CRYowF9-GLNa_hQrr-qJc9dJPeiA9BaLxw&oe=655E659D"),
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
                    'Trương Quang Khang',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.2175,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  // autogroupjrcfwjy (YEE1N2orUZYpXySghqjRCF)
                  width:  double.maxFinite,
                  height: 35.adaptSize,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // commentbuttonsNj (1:123)
                        margin: EdgeInsets.fromLTRB(
                            0.adaptSize, 0.adaptSize, 9.adaptSize, 0.adaptSize),
                        width:  120.adaptSize,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff0001cb),
                          borderRadius: BorderRadius.circular(8.adaptSize),
                        ),
                        child: Center(
                          child: Center(
                            child: Text(
                              'Nhắn tin',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.2125,
                                color: Color(0xfffafafa),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // commentbuttonEEw (4:220)
                        width:  120.adaptSize,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffb0b0b0),
                          borderRadius: BorderRadius.circular(8.adaptSize),
                        ),
                        child: Center(
                          child: Center(
                            child: Text(
                              'Hủy kết bạn',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.adaptSize,
                                fontWeight: FontWeight.w700,
                                height: 1.2125,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

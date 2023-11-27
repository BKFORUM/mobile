import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/friend_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendRequestWidget extends StatelessWidget {
  FriendRequestWidget(this.friendrequest, {Key? key}) : super(key: key);
  MyFriendModel friendrequest;

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
                  friendrequest.avatarUrl.toString()
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
                    friendrequest.fullName.toString(),
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
                              'Chấp Nhận',
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
                              'Hủy',
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

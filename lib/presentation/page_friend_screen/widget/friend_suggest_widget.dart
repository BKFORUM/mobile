import 'package:bkforum/controller/page_friend_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/user_model.dart';
import 'package:bkforum/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendSuggestWidget extends StatelessWidget {
  User friendSuggest = User();
  final PageFriendController controller = Get.put(PageFriendController());
  bool isClicked = false;
  FriendSuggestWidget(User user){
    this.friendSuggest = user;
    isClicked = user.friendStatus.toString() == TYPE_NOT_FRIEND;
  }

  // ignore: non_constant_identifier_names
  void ClickButtonAddFriends() {
    controller.createFriendRequest(friendSuggest.id.toString());
  }

  // ignore: non_constant_identifier_names
  void ClickButtonRetrieveRequest() {
    controller.updateStatusFriendSuggest(friendSuggest.id.toString(), "DELETED");
  }

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
                image: NetworkImage(friendSuggest.avatarUrl.toString()),
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
                    friendSuggest.fullName.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.2175,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                this.isClicked
                    ? CustomElevatedButton(
                        text: "Kết bạn",
                        height: 30.adaptSize,
                        width: double.infinity,
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0001cb),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // <-- Radius
                          ),
                        ),
                        buttonTextStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 1.2125,
                          color: Color(0xfffafafa),
                        ),
                        onTap: (){
                            ClickButtonAddFriends();
                        },
                      )
                    : CustomElevatedButton(
                        text: "Đã gừi lời mời kết bạn",
                        height: 30.adaptSize,
                        width: double.infinity,
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffb0b0b0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // <-- Radius
                          ),
                        ),
                        buttonTextStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 1.2125,
                          color:Color(0xff000000),
                        ),
                        onTap: (){
                            ClickButtonRetrieveRequest();
                        },
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

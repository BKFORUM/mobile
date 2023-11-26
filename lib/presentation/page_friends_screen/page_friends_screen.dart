
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_friends_screen/model/my_friend_model.dart';
import 'package:bkforum/presentation/page_friends_screen/page/page_friends_request.dart';
import 'package:bkforum/presentation/page_friends_screen/page/page_friends_suggest.dart';
import 'package:bkforum/presentation/page_friends_screen/page/page_my_friends.dart';
import 'package:bkforum/presentation/page_friends_screen/widget/friend_suggest_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'controller/page_friends_controller.dart';
import 'package:bkforum/presentation/page_friends_screen/model/friends_request_model.dart';
import 'package:bkforum/presentation/page_friends_screen/widget/friend_request_widget.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageFriendsScreen extends GetWidget<PageFriendsController> {
  PageFriendsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
           appBar: CustomAppBar(
                leadingWidth: 44.h,
                leading: AppbarImage(
                  imagePath: ImageConstant.imgIconhome,
                  margin: EdgeInsets.only(left: 24.h, top: 15.v, bottom: 15.v),
                ).animate().tint(color: Colors.amber).shake(),
                title: Padding(
                    padding: EdgeInsets.only(left: 19.h),
                    child: Row(children: [
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconWhiteSearch,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconsearch();
                          }),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconadd,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconaddone();
                          }),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconmessage,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconmessageone();
                          }),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconnotification,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconnotificatio();
                          }),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconMenu,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconavatarone();
                          })
                    ])),
                styleType: Style.bgOutline),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Container(
                    // frame194DuM (13:232)
                    padding: EdgeInsets.fromLTRB(
                        9.adaptSize, 6.adaptSize, 85.adaptSize, 6.adaptSize),
                    width: double.infinity,
                    height: 39.adaptSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0x33000000)),
                      color: Color(0xffffffff),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // commentbuttonb9D (13:235)
                          width: 82.adaptSize,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffb0b0b0),
                            borderRadius: BorderRadius.circular(15.adaptSize),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageFriendsRequest()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffb0b0b0)),
                            child: Text(
                              'Lời mời',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                height: 1.2125,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.adaptSize,
                        ),
                        Container(
                          // commentbuttonb9D (13:235)
                          width: 82.adaptSize,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffb0b0b0),
                            borderRadius: BorderRadius.circular(15.adaptSize),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageFriendsSuggest(
                                        controller
                                            .pageFriendsRequestModelObj.value)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffb0b0b0)),
                            child: Text(
                              'Đề xuất',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                height: 1.2125,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.adaptSize,
                        ),
                        Container(
                          // commentbuttonedH (13:237)
                          width: 82.adaptSize,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffb0b0b0),
                            borderRadius: BorderRadius.circular(15.adaptSize),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageMyFriends(
                                        controller
                                            .pageFriendsRequestModelObj.value)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffb0b0b0)),
                            child: Text(
                              'Bạn bè',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                height: 1.2125,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          decoration: AppDecoration.fillOnErrorContainer,
                          child: Center(
                              child: ListView(
                            children: [
                              Container(
                                // limiktbnPUX (21:72)
                                margin: EdgeInsets.fromLTRB(9.5.adaptSize,
                                    10.adaptSize, 5.adaptSize, 9.5.adaptSize),
                                child: Text(
                                  'Lời mời kết bạn',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10.v);
                                  },
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    MyFriendModel model = MyFriendModel();
                                    return FriendRequestWidget(model);
                                  }),
                              Container(
                                // group35Ehy (16:355)
                                margin: EdgeInsets.fromLTRB(30.adaptSize,
                                    0.adaptSize, 30.adaptSize, 0.adaptSize),
                                width: double.infinity,
                                height: 30.adaptSize,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(10.adaptSize),
                                ),
                                child: Container(
                                  // frame162xP5 (16:356)
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0001cb),
                                    borderRadius:
                                        BorderRadius.circular(10.adaptSize),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PageFriendsRequest()),
                                      );
                                    },
                                    child: Text(
                                      'Xem tất cả',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2125,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                // limiktbnPUX (21:72)
                                margin: EdgeInsets.fromLTRB(9.5.adaptSize,
                                    10.adaptSize, 5.adaptSize, 9.5.adaptSize),
                                child: Text(
                                  'Người bạn có thể biết',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10.v);
                                  },
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    FriendRequest model = controller
                                        .pageFriendsRequestModelObj
                                        .value
                                        .friendsRequest
                                        .value[0];
                                    return FriendSuggestWidget(model);
                                  }),
                              Container(
                                // group35Ehy (16:355)
                                margin: EdgeInsets.fromLTRB(30.adaptSize,
                                    0.adaptSize, 30.adaptSize, 0.adaptSize),
                                width: double.infinity,
                                height: 30.adaptSize,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(10.adaptSize),
                                ),
                                child: Container(
                                  // frame162xP5 (16:356)
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0001cb),
                                    borderRadius:
                                        BorderRadius.circular(10.adaptSize),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PageFriendsSuggest(controller
                                                    .pageFriendsRequestModelObj
                                                    .value)),
                                      );
                                    },
                                    child: Text(
                                      'Xem tất cả',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2125,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ))))
                ]))));
  }

  pressedButton() {
    Get.toNamed(AppRoutes.pageFriendsScreen, arguments: "suggest");
  }
  /// Navigates to the pageForumoneScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageForumoneScreen.
  onTapIconhomeone() {
    Get.toNamed(
      AppRoutes.pageForumoneScreen,
    );
  }

  /// Navigates to the pageSearchScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageSearchScreen.
  onTapIconsearch() {
    Get.toNamed(
      AppRoutes.pageSearchSreen,
    );
  }

  /// Navigates to the pageForumoneScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageForumoneScreen.
  onTapIconforumone() {
    Get.toNamed(
      AppRoutes.pageForumoneScreen,
    );
  }

  /// Navigates to the pageMessageScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageMessageScreen.
  onTapIconmessageone() {
    Get.toNamed(
      AppRoutes.pageMessageScreen,
    );
  }

  /// Navigates to the pagePostScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pagePostScreen.
  onTapIconaddone() {
    Get.toNamed(
      AppRoutes.pageFriendsScreen,
    );
  }

  /// Navigates to the pageNotificationScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageNotificationScreen.
  onTapIconnotificatio() {
    Get.toNamed(
      AppRoutes.pageNotificationScreen,
    );
  }

  /// Navigates to the pageSettingScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageSettingScreen.
  onTapIconavatarone() {
    Get.toNamed(
      AppRoutes.pageSettingScreen,
    );
  }
}
import 'package:bkforum/core/app_export.dart';
import 'controller/page_friends_controller.dart';
import 'package:bkforum/presentation/page_friends_screen/model/friends_request_model.dart';
import 'package:bkforum/presentation/page_friends_screen/widget/friend_request_widget.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_2.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PageFriendsScreen extends GetWidget<PageFriendsController> {
  const PageFriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                leadingWidth: 44.h,
                leading: AppbarImage(
                    imagePath: ImageConstant.imgIconhome,
                    margin:
                        EdgeInsets.only(left: 24.h, top: 15.v, bottom: 15.v),
                    onTap: () {
                      onTapIconhomeone();
                    }),
                title: Padding(
                    padding: EdgeInsets.only(left: 38.h),
                    child: Row(children: [
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconforum,
                          onTap: () {
                            onTapIconforumone();
                          }),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconmessage,
                          margin: EdgeInsets.only(left: 38.h),
                          onTap: () {
                            onTapIconmessageone();
                          })
                    ])),
                actions: [
                  AppbarImage2(
                      imagePath: ImageConstant.imgIconadd,
                      margin:
                          EdgeInsets.only(left: 25.h, top: 15.v, right: 15.h),
                      onTap: () {
                        onTapIconaddone();
                      }),
                  AppbarImage2(
                      imagePath: ImageConstant.imgIconnotification,
                      margin:
                          EdgeInsets.only(left: 38.h, top: 15.v, right: 15.h),
                      onTap: () {
                        onTapIconnotificatio();
                      }),
                  AppbarImage2(
                      imagePath: ImageConstant.imgIconnotification,
                      margin:
                          EdgeInsets.only(left: 38.h, top: 15.v, right: 15.h),
                      onTap: () {
                        onTapIconnotificatio();
                      }),
                ],
                styleType: Style.bgOutline),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Container(
                    // limiktbng6f (1:26)
                    // margin: EdgeInsets.fromLTRB(
                    //     6.adaptSize, 0.adaptSize, 0.adaptSize, 9.5.adaptSize),
                    child: Text(
                      'Lời mời kết bạn',
                      style: TextStyle(
                        fontSize: 16.adaptSize,
                        fontWeight: FontWeight.w600,
                        height: 1.2175,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          //margin: EdgeInsets.symmetric(horizontal: 3.h),
                          //padding: EdgeInsets.symmetric(vertical: 6.v),
                          decoration: AppDecoration.fillOnErrorContainer,
                          child: ListView.separated(
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
                                    .value[1];
                                return FriendRequestWidget(model);
                              })))
                ]))));
  }

  void onTapIconhomeone() {}

  void onTapIconforumone() {}

  void onTapIconaddone() {}

  void onTapIconmessageone() {}

  void onTapIconnotificatio() {}

  void onTapIconavatarone() {}
}

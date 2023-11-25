import 'dart:ffi';

import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/apiClient/notification_api.dart';

import '../user_post_screen.dart';
import '../../controller/page_notification_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../data/models/notification_model.dart';

class PageNotificationScreen extends GetWidget<PageNotificationController> {
  const PageNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(controller.pageNotificationModelObj.value.displayedNotifications);

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
                              margin: EdgeInsets.only(left: 19.h, right: 19.h))
                          .animate()
                          .tint(color: Colors.amber)
                          .shake(),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconMenu,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconavatarone();
                          })
                    ])),
                styleType: Style.bgFill),
            body: Flex(direction: Axis.vertical, children: [
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollStartNotification) {
                      setState(() {
                        //message = 'Scroll Started';
                      });
                    } else if (scrollNotification is ScrollUpdateNotification) {
                      setState(() {
                        //message = 'Scroll Updated';
                      });
                    } else if (scrollNotification is ScrollEndNotification) {
                        controller.pageNotificationModelObj.value.fetchMoreNotifications(
                            controller.pageNotificationModelObj.value.notifications.length
                        );
                    }
                    return true;
                  },
                  child: Obx(() => ListView.builder(
                        itemCount: controller.pageNotificationModelObj.value
                            .notifications.length.obs.value,
                        itemBuilder: (BuildContext context, int index) {
                          final notification = controller
                              .pageNotificationModelObj
                              .value
                              .notifications[index];
                          // print(notification.content?.value);
                          return ListTile(
                            leading: CustomImageView(
                              url: notification.sender!.value.avatarUrl!.value,
                              height: 36.adaptSize,
                              width: 36.adaptSize,
                              radius: BorderRadius.circular(9.h),
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              notification.sender!.value.fullName!.value+' '+notification.content!.value,
                              style: TextStyle(
                                fontWeight: notification.readAt!.value=='' ? FontWeight.w500 : FontWeight.w300,
                              ),
                            ),
                            onTap: () {
                              String? modelName = notification.modelName?.value;
                              String? modelId = notification.modelId?.value;

                              if (modelName == 'forum') {
                                // Get.to(ForumScreen(id: modelId));
                              } else if (modelName == 'post') {
                                // Get.to(UserPostScreen(id: modelId));
                              } else if (modelName == 'friendship') {
                                // Get.to(FriendshipScreen(id: modelId));
                              }
                            },
                          );
                        },
                      )),
                ),
              )
            ])));
  }

  /// Navigates to the pageFeedScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageFeedScreen.
  onTapIconhomeone() {
    Get.toNamed(
      AppRoutes.pageFeedScreen,
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
      AppRoutes.pagePostScreen,
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

  /// Navigates to the pageForumoneScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageForumoneScreen.
  onTapNotificationdet() {
    Get.toNamed(
      AppRoutes.pageForumoneScreen,
    );
  }
}




void setState(Null Function() param0) {}

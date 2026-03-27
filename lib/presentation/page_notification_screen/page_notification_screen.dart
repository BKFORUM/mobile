import 'package:bkforum/presentation/page_event_screen/event_details.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../controller/page_notification_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../data/models/data_prop/forum.dart';
import '../user_post_screen.dart';

class PageNotificationScreen extends GetWidget<PageNotificationController> {
  const PageNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(controller.pageNotificationModelObj.value.displayedNotifications);
    // var readAt;
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
                      setState(() {});
                    } else if (scrollNotification is ScrollUpdateNotification) {
                      setState(() {});
                    } else if (scrollNotification is ScrollEndNotification) {
                      controller.pageNotificationModelObj.value
                          .fetchMoreNotifications(controller
                              .pageNotificationModelObj
                              .value
                              .notifications
                              .length);
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
                          // final readAt = notification.readAt?.value.obs;
                          return ListTile(
                            leading: CustomImageView(
                              url: (notification
                                          .sender!.value.avatarUrl?.value !=
                                      null
                                  ? notification.sender!.value.avatarUrl?.value
                                  : 'https://res.cloudinary.com/dy7he6gby/image/upload/v1702533502/cps4mgrdt6ebuafatquu.png'),
                              height: 36.adaptSize,
                              width: 36.adaptSize,
                              radius: BorderRadius.circular(9.h),
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              (notification.sender!.value.fullName?.value !=
                                          null
                                      ? (notification
                                              .sender!.value.fullName!.value +
                                          ' ')
                                      : '') +
                                  notification.content!.value,
                              style: TextStyle(
                                fontWeight: notification.readAt?.value ==
                                        DateTime(2012, 1, 1)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            subtitle: Container(
                              padding: EdgeInsets.only(top: 4.adaptSize),
                              child: Text(
                                DateFormat('dd/MM/yyyy HH:mm')
                                    .format(notification.createdAt!.value),
                                style: TextStyle(
                                    color: notification.readAt?.value ==
                                            DateTime(2012, 1, 1)
                                        ? Colors.blue
                                        : Colors.black54),
                              ),
                            ),
                            trailing: (notification.readAt?.value ==
                                    DateTime(2012, 1, 1))
                                ? Icon(Icons.fiber_manual_record,
                                    color: Colors.blue, size: 12.adaptSize)
                                : SizedBox.shrink(),
                            onTap: () {
                              controller
                                  .setNotificationRead(notification.id?.value);
                              notification.readAt?.value = DateTime(2023);
                              String? modelName = notification.modelName?.value;
                              if (modelName == 'forum') {
                                final forum = Forum(
                                    id: notification.modelId!.value,
                                    name: '',
                                    modName: '');
                                Get.toNamed(AppRoutes.pageForumoneScreen,
                                    arguments: forum);
                              } else if (modelName == 'post') {
                                Get.to(() => UserPostScreen(),
                                    arguments: notification.modelId?.value,
                                    transition: Transition.rightToLeft);
                              } else if (modelName == 'friendship') {
                                // Get.to(FriendshipScreen(id: modelId));
                              } else if (modelName == 'event') {
                                Get.to(() => EventDetail(),
                                    arguments: notification.modelId?.value,
                                    transition: Transition.rightToLeft);
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

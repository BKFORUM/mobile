import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/apiClient/profile_api.dart';
import '../../data/models/profile_model.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/userpost_item_widget.dart';
import '../../controller/page_feed_controller.dart';
import '../../data/models/userpost_item_model.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PageFeedScreen extends GetView<PageFeedController> {
  const PageFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Profile? fetchedProfile;

    ProfileApi().fetchProfile('').then((profile) async {
      fetchedProfile = Profile(
        id: profile.id,
        fullName: profile.fullName,
        avatarUrl: profile.avatarUrl,
        email: profile.email,
        address: profile.address,
        phoneNumber: profile.phoneNumber,
        faculty: profile.faculty,
        type: profile.type,
      );
      final preferences = await SharedPreferences.getInstance();
      preferences.setString('user_id', fetchedProfile!.id);
      preferences.setString('user_fullName', fetchedProfile!.fullName);
      if (fetchedProfile?.avatarUrl != null) {
        preferences.setString('user_avatarUrl', fetchedProfile!.avatarUrl!);
      }
      if (fetchedProfile?.email != null) {
        preferences.setString('user_email', fetchedProfile!.email!);
      }
      if (fetchedProfile?.address != null) {
        preferences.setString('user_address', fetchedProfile!.address!);
      }
      if (fetchedProfile?.phoneNumber != null) {
        preferences.setString('user_phoneNumber', fetchedProfile!.phoneNumber!);
      }
      if (fetchedProfile?.faculty != null) {
        preferences.setString('user_facultyId', fetchedProfile!.faculty!.id);
        preferences.setString(
            'user_facultyName', fetchedProfile!.faculty!.name);
      }
      if (fetchedProfile?.type != null) {
        preferences.setString('user_type', fetchedProfile!.type!);
      }
    }).catchError((error) {
      print('Error: $error');
    });

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
            body: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                  } else if (scrollNotification is ScrollUpdateNotification) {
                  } else if (scrollNotification is ScrollEndNotification) {
                    controller.pageFeedModelObj.value.fetchMorePosts(controller
                        .pageFeedModelObj.value.userpostItemList.value.length);
                  }
                  return true;
                },
                child: Obx(() => RefreshIndicator(
                      onRefresh: () async => controller.refreshPageFeedData(),
                      child: controller.pageFeedModelObj.value.userpostItemList
                              .value.isEmpty
                          ? Center(
                              child: CustomProgressIndicator(),
                            )
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 10.v,
                                  color: Colors.black12,
                                );
                              },
                              itemCount: controller.pageFeedModelObj.value
                                  .userpostItemList.value.length.obs.value,
                              itemBuilder: (context, index) {
                                UserpostItemModel model = controller
                                    .pageFeedModelObj
                                    .value
                                    .userpostItemList
                                    .value[index];
                                return UserpostItemWidget(model);
                              },
                            ),
                    )))
        ));
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
      AppRoutes.pagePostScreen,
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

Future<SharedPreferences> getLocalProfile() async {
  final preferences = await SharedPreferences.getInstance();
  return preferences;
}

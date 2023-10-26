import 'package:flutter_animate/flutter_animate.dart';

import 'controller/page_setting_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_circleimage.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_2.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PageSettingScreen extends GetWidget<PageSettingController> {
  const PageSettingScreen({Key? key}) : super(key: key);

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
                    padding: EdgeInsets.only(left: 19.h),
                    child: Row(children: [
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconforum,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconforumone();
                          }),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconmessage,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconmessageone();
                          }),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconadd,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconaddone();
                          }),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconnotification,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconnotificatio();
                          }),
                      AppbarCircleimage(
                          imagePath: ImageConstant.imgIconavatar,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                      ).animate().fadeIn().slide(duration: 100.ms)
                    ])),
                styleType: Style.bgFill),
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillOnErrorContainer,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 83.h, vertical: 14.v),
                          decoration: AppDecoration.fillOnErrorContainer,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(height: 9.v),
                                CustomImageView(
                                    imagePath: ImageConstant.imgIconavatar40x40,
                                    height: 70.adaptSize,
                                    width: 70.adaptSize,
                                    radius: BorderRadius.circular(20.h)),
                                SizedBox(height: 13.v),
                                Text("msg_nguy_n_nh_t_h_ng2".tr,
                                    style: CustomTextStyles.titleMedium18)
                              ])),
                      Padding(
                          padding: EdgeInsets.only(left: 20.h, top: 20.v),
                          child: Row(children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgIconswap,
                                height: 26.adaptSize,
                                width: 26.adaptSize),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 19.h, top: 3.v, bottom: 2.v),
                                child: Text("lbl_i_m_t_kh_u".tr,
                                    style: CustomTextStyles.bodyLargeInter))
                          ])),
                      GestureDetector(
                          onTap: () {
                            onTapRowiconexitone();
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20.h, top: 40.v, bottom: 5.v),
                              child: Row(children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgIconexit,
                                    height: 26.adaptSize,
                                    width: 26.adaptSize),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 19.h, top: 3.v, bottom: 2.v),
                                    child: Text("lbl_ng_xu_t".tr,
                                        style: CustomTextStyles.bodyLargeInter))
                              ])))
                    ]))));
  }

  /// Navigates to the pageFeedScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageFeedScreen.
  onTapIconhomeone() {
    Get.toNamed(
      AppRoutes.pageFeedScreen,
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

  /// Navigates to the pageLoginScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageLoginScreen.
  onTapRowiconexitone() {
    Get.toNamed(
      AppRoutes.pageLoginScreen,
    );
  }
}

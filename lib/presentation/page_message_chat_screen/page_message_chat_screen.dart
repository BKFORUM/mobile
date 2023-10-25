import 'controller/page_message_chat_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_circleimage.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_2.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PageMessageChatScreen extends GetWidget<PageMessageChatController> {
  const PageMessageChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillOnErrorContainer,
                child: Column(children: [
                  Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 12.v),
                      decoration: AppDecoration.fillGray100.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderLR10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgIconback,
                                height: 30.adaptSize,
                                width: 30.adaptSize,
                                margin: EdgeInsets.symmetric(vertical: 1.v),
                                onTap: () {
                                  // onTapImgIconbackone();
                                  Get.back();
                                }),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder13),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 7.v),
                                          child: Text("msg_nguy_n_ph_m_nam".tr,
                                              style: CustomTextStyles
                                                  .titleSmallBlack900)),
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgIconavatar32x32,
                                          height: 32.adaptSize,
                                          width: 32.adaptSize,
                                          radius: BorderRadius.circular(16.h),
                                          margin: EdgeInsets.only(left: 10.h))
                                    ]))
                          ])),
                  Container(
                      decoration: AppDecoration.outlineBlack.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder13),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(height: 13.v),
                        Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.h, vertical: 4.v),
                            decoration: AppDecoration.fillOnErrorContainer
                                .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.customBorderLR10),
                            child: Row(children: [
                              CustomImageView(
                                  imagePath: ImageConstant.imgEllipse3,
                                  height: 36.adaptSize,
                                  width: 36.adaptSize,
                                  radius: BorderRadius.circular(18.h)),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.h, top: 10.v, bottom: 8.v),
                                  child: Text("msg_l_m_b_i_t_p_ch_a".tr,
                                      style: CustomTextStyles
                                          .bodyMediumBlack900_1))
                            ])),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 13.v),
                            decoration: AppDecoration.fillOnErrorContainer
                                .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.customBorderLR10),
                            child: Text("lbl_ch_a_bro".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 4.v),
                            decoration: AppDecoration.fillOnErrorContainer
                                .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.customBorderLR10),
                            child: Container(
                                width: 281.h,
                                margin: EdgeInsets.only(left: 26.h),
                                child: Text("msg_nh_ng_m_tui_c".tr,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: CustomTextStyles
                                        .bodyMediumBlack900_1))),
                        Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.h, vertical: 4.v),
                            decoration: AppDecoration.fillOnErrorContainer
                                .copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.customBorderLR10),
                            child: Row(children: [
                              CustomImageView(
                                  imagePath: ImageConstant.imgEllipse3,
                                  height: 36.adaptSize,
                                  width: 36.adaptSize,
                                  radius: BorderRadius.circular(18.h)),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.h, top: 9.v, bottom: 9.v),
                                  child: Text("lbl_c".tr,
                                      style: CustomTextStyles
                                          .bodyMediumBlack900_1))
                            ])),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 12.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 12.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 12.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 12.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 12.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 12.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 12.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 12.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 12.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 26.h, vertical: 7.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Text("lbl_i_t_nh".tr,
                                style: CustomTextStyles.bodyMediumBlack900_1))
                      ])),
                  Padding(
                      padding: EdgeInsets.fromLTRB(14.h, 15.v, 14.h, 5.v),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                                svgPath: ImageConstant.imgFrame,
                                height: 39.v,
                                width: 62.h),
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: 14.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.h, vertical: 7.v),
                                    decoration: AppDecoration.fillGray100
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .circleBorder20),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.v),
                                              child: Text("lbl_aa".tr,
                                                  style: CustomTextStyles
                                                      .bodyLargeRobotoGray700)),
                                          CustomImageView(
                                              svgPath:
                                                  ImageConstant.imgIconsend2,
                                              height: 23.v,
                                              width: 24.h)
                                        ])))
                          ]))
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

  /// Navigates to the pageSettingScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageSettingScreen.
  onTapIconavatarone() {
    Get.toNamed(
      AppRoutes.pageSettingScreen,
    );
  }

  /// Navigates to the pageMessageScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageMessageScreen.
  onTapImgIconbackone() {
    Get.toNamed(
      AppRoutes.pageMessageScreen,
    );
  }
}

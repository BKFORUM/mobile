import 'package:flutter_animate/flutter_animate.dart';

import '../page_forumone_screen/widgets/userpost1_item_widget.dart';
import 'controller/page_forumone_controller.dart';
import 'models/userpost1_item_model.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_circleimage.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_2.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PageForumoneScreen extends GetWidget<PageForumoneController> {
  const PageForumoneScreen({Key? key}) : super(key: key);

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
                      ).animate().tint(color: Colors.amber).shake(),
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
                          onTap: () {
                            onTapIconavatarone();
                          })
                    ])),
                styleType: Style.bgOutline),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.all(8.h),
                      decoration: AppDecoration.fillGray,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 1.v),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                      imagePath: ImageConstant.imgIconavatar,
                                      height: 20.adaptSize,
                                      width: 20.adaptSize,
                                      radius: BorderRadius.circular(10.h)),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 8.h, top: 2.v),
                                      child: Text(
                                          "msg_l_p_sinh_ho_t_20tclc_dt4".tr,
                                          style: CustomTextStyles
                                              .titleSmallBlack900)),
                                  CustomImageView(
                                      imagePath: ImageConstant.imgIconsearch,
                                      height: 16.adaptSize,
                                      width: 16.adaptSize,
                                      margin: EdgeInsets.only(
                                          left: 41.h, top: 2.v, bottom: 2.v)),
                                  CustomImageView(
                                      imagePath: ImageConstant.imgIconexit,
                                      height: 16.adaptSize,
                                      width: 16.adaptSize,
                                      margin: EdgeInsets.only(
                                          left: 20.h, top: 2.v, bottom: 2.v)),
                                  CustomImageView(
                                      imagePath: ImageConstant.imgIcondrop,
                                      height: 16.adaptSize,
                                      width: 16.adaptSize,
                                      margin: EdgeInsets.only(
                                          left: 20.h, top: 2.v, bottom: 2.v))
                                ]),
                            SizedBox(height: 8.v),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("msg_nguy_n_nh_t_h_ng".tr,
                                      style:
                                          CustomTextStyles.bodySmallBlack900),
                                  Text("lbl_moderator".tr,
                                      style: CustomTextStyles
                                          .bodySmallPrimaryContainer)
                                ])
                          ])),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.h),
                          padding: EdgeInsets.symmetric(vertical: 6.v),
                          decoration: AppDecoration.fillOnErrorContainer,
                          child: Obx(() => ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 10.v);
                              },
                              itemCount: controller.pageForumoneModelObj.value
                                  .userpost1ItemList.value.length,
                              itemBuilder: (context, index) {
                                Userpost1ItemModel model = controller
                                    .pageForumoneModelObj
                                    .value
                                    .userpost1ItemList
                                    .value[index];
                                return Userpost1ItemWidget(model);
                              }))))
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

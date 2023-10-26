import 'package:flutter_animate/flutter_animate.dart';

import 'controller/page_notification_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_circleimage.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_2.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PageNotificationScreen extends GetWidget<PageNotificationController> {
  const PageNotificationScreen({Key? key}) : super(key: key);

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
                          margin: EdgeInsets.only(left: 19.h, right: 19.h)
                      ).animate().tint(color: Colors.amber).shake(),
                      AppbarCircleimage(
                          imagePath: ImageConstant.imgIconavatar,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconavatarone();
                          })
                    ])),
                styleType: Style.bgFill),
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillOnErrorContainer,
                child:
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        // Logic of scrollNotification
                        if (scrollNotification is ScrollStartNotification) {
                          setState(() {
                            //message = 'Scroll Started';
                          });
                        } else if (scrollNotification is ScrollUpdateNotification) {
                          setState(() {
                            //message = 'Scroll Updated';
                          });
                        } else if (scrollNotification is ScrollEndNotification) {
                          setState(() {
                            // message = 'Scroll Ended';
                          });
                        }
                        return true;
                      },
                      // child of type required. Which means its compulsory to pass in NotificationListener
                      child: ListView.builder(
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Thông báo $index'),
                            );
                          }),
                    ),
                  )
                // child: Column(
                //
                //     children: [
                //   GestureDetector(
                //       onTap: () {
                //         onTapNotificationdet();
                //       },
                //       child: Container(
                //           width: double.maxFinite,
                //           padding: EdgeInsets.symmetric(
                //               horizontal: 14.h, vertical: 11.v),
                //           decoration: AppDecoration.fillOnErrorContainer,
                //           child: Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 CustomImageView(
                //                     imagePath: ImageConstant.imgIconavatar30x30,
                //                     height: 30.adaptSize,
                //                     width: 30.adaptSize,
                //                     radius: BorderRadius.circular(15.h),
                //                     margin:
                //                         EdgeInsets.symmetric(vertical: 15.v)),
                //                 Expanded(
                //                     child: Container(
                //                         width: 278.h,
                //                         margin: EdgeInsets.only(left: 10.h),
                //                         child: RichText(
                //                             text: TextSpan(children: [
                //                               TextSpan(
                //                                   text: "msg_tr_ng_quang_khang"
                //                                       .tr,
                //                                   style: theme
                //                                       .textTheme.titleMedium),
                //                               TextSpan(
                //                                   text: "msg_b_y_t_c_m_x_c".tr,
                //                                   style: CustomTextStyles
                //                                       .bodyLargeInter_1),
                //                               TextSpan(
                //                                   text:
                //                                       "msg_l_p_sinh_ho_t_20tclc_dt4"
                //                                           .tr,
                //                                   style: theme
                //                                       .textTheme.titleMedium)
                //                             ]),
                //                             textAlign: TextAlign.left)))
                //               ]))),
                //   Container(
                //       width: double.maxFinite,
                //       padding: EdgeInsets.symmetric(
                //           horizontal: 14.h, vertical: 11.v),
                //       decoration: AppDecoration.fillOnErrorContainer,
                //       child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             CustomImageView(
                //                 imagePath: ImageConstant.imgIconavatar30x30,
                //                 height: 30.adaptSize,
                //                 width: 30.adaptSize,
                //                 radius: BorderRadius.circular(15.h),
                //                 margin: EdgeInsets.symmetric(vertical: 15.v)),
                //             Expanded(
                //                 child: Container(
                //                     width: 278.h,
                //                     margin: EdgeInsets.only(left: 10.h),
                //                     child: RichText(
                //                         text: TextSpan(children: [
                //                           TextSpan(
                //                               text: "msg_tr_ng_quang_khang".tr,
                //                               style:
                //                                   theme.textTheme.titleMedium),
                //                           TextSpan(
                //                               text: "msg_b_y_t_c_m_x_c".tr,
                //                               style: CustomTextStyles
                //                                   .bodyLargeInter_1),
                //                           TextSpan(
                //                               text:
                //                                   "msg_l_p_sinh_ho_t_20tclc_dt4"
                //                                       .tr,
                //                               style:
                //                                   theme.textTheme.titleMedium)
                //                         ]),
                //                         textAlign: TextAlign.left)))
                //           ])),
                //   Container(
                //       width: double.maxFinite,
                //       padding: EdgeInsets.symmetric(
                //           horizontal: 14.h, vertical: 11.v),
                //       decoration: AppDecoration.fillOnErrorContainer,
                //       child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             CustomImageView(
                //                 imagePath: ImageConstant.imgIconavatar30x30,
                //                 height: 30.adaptSize,
                //                 width: 30.adaptSize,
                //                 radius: BorderRadius.circular(15.h),
                //                 margin: EdgeInsets.symmetric(vertical: 15.v)),
                //             Expanded(
                //                 child: Container(
                //                     width: 278.h,
                //                     margin: EdgeInsets.only(left: 10.h),
                //                     child: RichText(
                //                         text: TextSpan(children: [
                //                           TextSpan(
                //                               text: "msg_tr_ng_quang_khang".tr,
                //                               style:
                //                                   theme.textTheme.titleMedium),
                //                           TextSpan(
                //                               text: "msg_b_y_t_c_m_x_c".tr,
                //                               style: CustomTextStyles
                //                                   .bodyLargeInter_1),
                //                           TextSpan(
                //                               text:
                //                                   "msg_l_p_sinh_ho_t_20tclc_dt4"
                //                                       .tr,
                //                               style:
                //                                   theme.textTheme.titleMedium)
                //                         ]),
                //                         textAlign: TextAlign.left)))
                //           ])),
                //   Container(
                //       width: double.maxFinite,
                //       padding: EdgeInsets.symmetric(
                //           horizontal: 14.h, vertical: 11.v),
                //       decoration: AppDecoration.fillOnErrorContainer,
                //       child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             CustomImageView(
                //                 imagePath: ImageConstant.imgIconavatar30x30,
                //                 height: 30.adaptSize,
                //                 width: 30.adaptSize,
                //                 radius: BorderRadius.circular(15.h),
                //                 margin: EdgeInsets.symmetric(vertical: 15.v)),
                //             Expanded(
                //                 child: Container(
                //                     width: 278.h,
                //                     margin: EdgeInsets.only(left: 10.h),
                //                     child: RichText(
                //                         text: TextSpan(children: [
                //                           TextSpan(
                //                               text: "msg_tr_ng_quang_khang".tr,
                //                               style:
                //                                   theme.textTheme.titleMedium),
                //                           TextSpan(
                //                               text: "msg_b_y_t_c_m_x_c".tr,
                //                               style: CustomTextStyles
                //                                   .bodyLargeInter_1),
                //                           TextSpan(
                //                               text:
                //                                   "msg_l_p_sinh_ho_t_20tclc_dt4"
                //                                       .tr,
                //                               style:
                //                                   theme.textTheme.titleMedium)
                //                         ]),
                //                         textAlign: TextAlign.left)))
                //           ])),
                //   Container(
                //       width: double.maxFinite,
                //       padding: EdgeInsets.symmetric(
                //           horizontal: 14.h, vertical: 11.v),
                //       decoration: AppDecoration.fillOnErrorContainer,
                //       child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             CustomImageView(
                //                 imagePath: ImageConstant.imgIconavatar30x30,
                //                 height: 30.adaptSize,
                //                 width: 30.adaptSize,
                //                 radius: BorderRadius.circular(15.h),
                //                 margin: EdgeInsets.symmetric(vertical: 15.v)),
                //             Expanded(
                //                 child: Container(
                //                     width: 278.h,
                //                     margin: EdgeInsets.only(left: 10.h),
                //                     child: RichText(
                //                         text: TextSpan(children: [
                //                           TextSpan(
                //                               text: "msg_tr_ng_quang_khang".tr,
                //                               style:
                //                                   theme.textTheme.titleMedium),
                //                           TextSpan(
                //                               text: "msg_b_y_t_c_m_x_c".tr,
                //                               style: CustomTextStyles
                //                                   .bodyLargeInter_1),
                //                           TextSpan(
                //                               text:
                //                                   "msg_l_p_sinh_ho_t_20tclc_dt4"
                //                                       .tr,
                //                               style:
                //                                   theme.textTheme.titleMedium)
                //                         ]),
                //                         textAlign: TextAlign.left)))
                //           ])),
                //   Container(
                //       width: double.maxFinite,
                //       padding: EdgeInsets.symmetric(
                //           horizontal: 14.h, vertical: 11.v),
                //       decoration: AppDecoration.fillOnErrorContainer,
                //       child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             CustomImageView(
                //                 imagePath: ImageConstant.imgIconavatar30x30,
                //                 height: 30.adaptSize,
                //                 width: 30.adaptSize,
                //                 radius: BorderRadius.circular(15.h),
                //                 margin: EdgeInsets.symmetric(vertical: 15.v)),
                //             Expanded(
                //                 child: Container(
                //                     width: 278.h,
                //                     margin: EdgeInsets.only(left: 10.h),
                //                     child: RichText(
                //                         text: TextSpan(children: [
                //                           TextSpan(
                //                               text: "msg_tr_ng_quang_khang".tr,
                //                               style:
                //                                   theme.textTheme.titleMedium),
                //                           TextSpan(
                //                               text: "msg_b_y_t_c_m_x_c".tr,
                //                               style: CustomTextStyles
                //                                   .bodyLargeInter_1),
                //                           TextSpan(
                //                               text:
                //                                   "msg_l_p_sinh_ho_t_20tclc_dt4"
                //                                       .tr,
                //                               style:
                //                                   theme.textTheme.titleMedium)
                //                         ]),
                //                         textAlign: TextAlign.left)))
                //           ])),
                //   Container(
                //       width: double.maxFinite,
                //       padding: EdgeInsets.symmetric(
                //           horizontal: 14.h, vertical: 11.v),
                //       decoration: AppDecoration.fillOnErrorContainer,
                //       child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             CustomImageView(
                //                 imagePath: ImageConstant.imgIconavatar30x30,
                //                 height: 30.adaptSize,
                //                 width: 30.adaptSize,
                //                 radius: BorderRadius.circular(15.h),
                //                 margin: EdgeInsets.symmetric(vertical: 15.v)),
                //             Expanded(
                //                 child: Container(
                //                     width: 278.h,
                //                     margin: EdgeInsets.only(left: 10.h),
                //                     child: RichText(
                //                         text: TextSpan(children: [
                //                           TextSpan(
                //                               text: "msg_tr_ng_quang_khang".tr,
                //                               style:
                //                                   theme.textTheme.titleMedium),
                //                           TextSpan(
                //                               text: "msg_b_y_t_c_m_x_c".tr,
                //                               style: CustomTextStyles
                //                                   .bodyLargeInter_1),
                //                           TextSpan(
                //                               text:
                //                                   "msg_l_p_sinh_ho_t_20tclc_dt4"
                //                                       .tr,
                //                               style:
                //                                   theme.textTheme.titleMedium)
                //                         ]),
                //                         textAlign: TextAlign.left)))
                //           ])),
                //   Container(
                //       width: double.maxFinite,
                //       padding: EdgeInsets.symmetric(
                //           horizontal: 14.h, vertical: 11.v),
                //       decoration: AppDecoration.fillOnErrorContainer,
                //       child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             CustomImageView(
                //                 imagePath: ImageConstant.imgIconavatar30x30,
                //                 height: 30.adaptSize,
                //                 width: 30.adaptSize,
                //                 radius: BorderRadius.circular(15.h),
                //                 margin: EdgeInsets.symmetric(vertical: 15.v)),
                //             Expanded(
                //                 child: Container(
                //                     width: 278.h,
                //                     margin: EdgeInsets.only(left: 10.h),
                //                     child: RichText(
                //                         text: TextSpan(children: [
                //                           TextSpan(
                //                               text: "msg_tr_ng_quang_khang".tr,
                //                               style:
                //                                   theme.textTheme.titleMedium),
                //                           TextSpan(
                //                               text: "msg_b_y_t_c_m_x_c".tr,
                //                               style: CustomTextStyles
                //                                   .bodyLargeInter_1),
                //                           TextSpan(
                //                               text:
                //                                   "msg_l_p_sinh_ho_t_20tclc_dt4"
                //                                       .tr,
                //                               style:
                //                                   theme.textTheme.titleMedium)
                //                         ]),
                //                         textAlign: TextAlign.left)))
                //           ])),
                //   Container(
                //       width: double.maxFinite,
                //       padding: EdgeInsets.symmetric(horizontal: 14.h),
                //       decoration: AppDecoration.fillOnErrorContainer,
                //       child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [
                //             CustomImageView(
                //                 imagePath: ImageConstant.imgIconavatar30x30,
                //                 height: 30.adaptSize,
                //                 width: 30.adaptSize,
                //                 radius: BorderRadius.circular(15.h),
                //                 margin:
                //                     EdgeInsets.only(top: 27.v, bottom: 12.v)),
                //             Expanded(
                //                 child: Container(
                //                     width: 278.h,
                //                     margin:
                //                         EdgeInsets.only(left: 10.h, top: 11.v),
                //                     child: RichText(
                //                         text: TextSpan(children: [
                //                           TextSpan(
                //                               text: "msg_tr_ng_quang_khang".tr,
                //                               style:
                //                                   theme.textTheme.titleMedium),
                //                           TextSpan(
                //                               text: "msg_b_y_t_c_m_x_c".tr,
                //                               style: CustomTextStyles
                //                                   .bodyLargeInter_1),
                //                           TextSpan(
                //                               text:
                //                                   "msg_l_p_sinh_ho_t_20tclc_dt4"
                //                                       .tr,
                //                               style:
                //                                   theme.textTheme.titleMedium)
                //                         ]),
                //                         textAlign: TextAlign.left)))
                //           ]))
                // ]
                // )
            )
        )
    );
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

void setState(Null Function() param0) {
}

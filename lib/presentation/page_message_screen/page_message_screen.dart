import 'package:flutter_animate/flutter_animate.dart';

import '../../data/apiClient/profile_api.dart';
import '../../data/models/profile_model.dart';
import 'controller/page_message_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_circleimage.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_2.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:bkforum/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PageMessageScreen extends GetWidget<PageMessageController> {
  const PageMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Profile? fetchedProfile;
    ProfileApi().fetchProfile().then((profile) {
      fetchedProfile = Profile(
        id: profile.id,
        fullName: profile.fullName,
        avatarUrl: profile.avatarUrl,
        email: profile.email,
        address: profile.address,
        faculty: profile.faculty,
        type: profile.type,
      );
      print(fetchedProfile?.fullName);
    }).catchError((error) {
      print('Error: $error');
    });

    mediaQueryData = MediaQuery.of(context);
    return FutureBuilder<Profile>(
      future: ProfileApi().fetchProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.white,
              ));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final fetchedProfile = snapshot.data!;
          return SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
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
                            ).animate().tint(color: Colors.amber).shake(),
                            AppbarImage2(
                                imagePath: ImageConstant.imgIconadd,
                                margin: EdgeInsets.only(left: 19.h, right: 19.h),
                                onTap: () {
                                  onTapIconaddone();
                                }),
                            AppbarImage2(
                                imagePath: ImageConstant.imgIconnotification,
                                margin: EdgeInsets.only(left: 19.h, right: 19.h),
                                onTap: () {
                                  onTapIconnotificatio();
                                }),
                            AppbarCircleimage(
                                url: fetchedProfile.avatarUrl,
                                margin: EdgeInsets.only(left: 19.h, right: 19.h),
                                onTap: () {
                                  onTapIconavatarone();
                                })
                          ])),
                      styleType: Style.bgFill),
                  body: Container(
                      width: double.maxFinite,
                      decoration: AppDecoration.fillOnErrorContainer,
                      child: Column(children: [
                        Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.v),
                            decoration: AppDecoration.fillOnErrorContainer,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: 8.v),
                                  CustomTextFormField(
                                      controller: controller.tmkimController,
                                      hintText: "lbl_t_m_ki_m".tr,
                                      hintStyle:
                                      CustomTextStyles.bodySmallPrimaryContainer,
                                      textInputAction: TextInputAction.done,
                                      borderDecoration:
                                      TextFormFieldStyleHelper.fillBlueGray,
                                      filled: true,
                                      fillColor: appTheme.blueGray100)
                                ])),
                        //           Container(
                        //               width: double.maxFinite,
                        //               padding: EdgeInsets.symmetric(vertical: 8.v),
                        //               decoration: AppDecoration.fillOnErrorContainer,
                        //               child: Expanded(
                        //                 child: ListView(
                        //                   scrollDirection: Axis.horizontal,
                        //                   children: [
                        //                     CustomImageView(
                        //                         imagePath: ImageConstant.imgIconavatar40x40,
                        //                         height: 40.adaptSize,
                        //                         width: 40.adaptSize,
                        //                         radius: BorderRadius.circular(20.h),
                        //                         margin: EdgeInsets.only(left: 14.h)),
                        //                     CustomImageView(
                        //                         imagePath: ImageConstant.imgIconavatar40x40,
                        //                         height: 40.adaptSize,
                        //                         width: 40.adaptSize,
                        //                         radius: BorderRadius.circular(20.h)),
                        //                     CustomImageView(
                        //                         imagePath: ImageConstant.imgIconavatar40x40,
                        //                         height: 40.adaptSize,
                        //                         width: 40.adaptSize,
                        //                         radius: BorderRadius.circular(20.h)),
                        //                     CustomImageView(
                        //                         imagePath: ImageConstant.imgIconavatar40x40,
                        //                         height: 40.adaptSize,
                        //                         width: 40.adaptSize,
                        //                         radius: BorderRadius.circular(20.h)),
                        //                     CustomImageView(
                        //                         imagePath: ImageConstant.imgIconavatar40x40,
                        //                         height: 40.adaptSize,
                        //                         width: 40.adaptSize,
                        //                         radius: BorderRadius.circular(20.h)),
                        //                     CustomImageView(
                        //                         imagePath: ImageConstant.imgIconavatar40x26,
                        //                         height: 40.v,
                        //                         width: 26.h,
                        //                         radius: BorderRadius.circular(13.h))
                        //                   ],
                        //                 ),
                        //               )
                        // ),
                        Container(
                            child:
                            Expanded(
                              child: ListView.builder(
                                // padding: EdgeInsets.symmetric(horizontal: 8.h),
                                  itemCount: 100,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        leading: CustomImageView(
                                            imagePath: ImageConstant.imgIconavatar28x28,
                                            height: 30.adaptSize,
                                            width: 30.adaptSize,
                                            radius: BorderRadius.circular(14.h),
                                            margin: EdgeInsets.symmetric(vertical: 1.v)),
                                        title: Text("msg_nguy_n_nh_t_h_ng".tr, style: CustomTextStyles.titleMediumHelvetica),
                                        subtitle:Text("msg_ho_t_ng_10_ph_t".tr, style: theme.textTheme.bodySmall),
                                        onTap: (){
                                          onTapBoxchatboxinfo();
                                        });
                                  }),
                            )
                          // child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       SizedBox(height: 12.v),
                          //       GestureDetector(
                          //           onTap: () {
                          //             onTapBoxchatboxinfo();
                          //           },
                          //           child: Row(children: [
                          //             CustomImageView(
                          //                 imagePath:
                          //                     ImageConstant.imgIconavatar28x28,
                          //                 height: 28.adaptSize,
                          //                 width: 28.adaptSize,
                          //                 radius: BorderRadius.circular(14.h),
                          //                 margin: EdgeInsets.symmetric(
                          //                     vertical: 3.v)),
                          //             Padding(
                          //                 padding: EdgeInsets.only(left: 10.h),
                          //                 child: Column(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Text("msg_nguy_n_ph_m_nam".tr,
                          //                           style: CustomTextStyles
                          //                               .titleMediumHelvetica),
                          //                       SizedBox(height: 3.v),
                          //                       Text("msg_ho_t_ng_10_ph_t".tr,
                          //                           style: theme
                          //                               .textTheme.bodySmall)
                          //                     ]))
                          //           ])),
                          //       SizedBox(height: 24.v),
                          //       Row(children: [
                          //         CustomImageView(
                          //             imagePath:
                          //                 ImageConstant.imgIconavatar28x28,
                          //             height: 28.adaptSize,
                          //             width: 28.adaptSize,
                          //             radius: BorderRadius.circular(14.h),
                          //             margin:
                          //                 EdgeInsets.symmetric(vertical: 3.v)),
                          //         Padding(
                          //             padding: EdgeInsets.only(left: 10.h),
                          //             child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: [
                          //                   Text("msg_nguy_n_nh_t_h_ng".tr,
                          //                       style: CustomTextStyles
                          //                           .titleMediumHelvetica),
                          //                   SizedBox(height: 3.v),
                          //                   Text("msg_ho_t_ng_10_ph_t".tr,
                          //                       style:
                          //                           theme.textTheme.bodySmall)
                          //                 ]))
                          //       ]),
                          //
                        )
                      ]))));
        }

      }
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

  /// Navigates to the pageMessageChatScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageMessageChatScreen.
  onTapBoxchatboxinfo() {
    Get.toNamed(
      AppRoutes.pageMessageChatScreen,
    );
  }
}

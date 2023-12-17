import 'package:bkforum/controller/page_messsage_controller.dart';
import 'package:bkforum/presentation/page_message_screen/widget/conversation_widget.dart';
import 'package:bkforum/widgets/progress_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/apiClient/profile_api.dart';
import '../../data/models/profile_model.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PageMessageScreen extends GetWidget<PageMessageController> {
  const PageMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Profile? fetchedProfile;
    ProfileApi().fetchProfile('').then((profile) {
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
        future: ProfileApi().fetchProfile(''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return SafeArea(
                child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: CustomAppBar(
                        leadingWidth: 44.h,
                        leading: AppbarImage(
                          imagePath: ImageConstant.imgIconhome,
                          margin: EdgeInsets.only(
                              left: 24.h, top: 15.v, bottom: 15.v),
                        ),
                        title: Padding(
                            padding: EdgeInsets.only(left: 19.h),
                            child: Row(children: [
                              AppbarImage1(
                                  imagePath: ImageConstant.imgIconWhiteSearch,
                                  margin:
                                      EdgeInsets.only(left: 19.h, right: 19.h),
                                  onTap: () {
                                    onTapIconsearch();
                                  }),
                              AppbarImage1(
                                  imagePath: ImageConstant.imgIconadd,
                                  margin:
                                      EdgeInsets.only(left: 19.h, right: 19.h),
                                  onTap: () {
                                    onTapIconaddone();
                                  }),
                              AppbarImage1(
                                      imagePath: ImageConstant.imgIconmessage,
                                      margin: EdgeInsets.only(
                                          left: 19.h, right: 19.h),
                                      onTap: () {
                                        onTapIconmessageone();
                                      })
                                  .animate()
                                  .tint(color: Colors.amber)
                                  .shake(),
                              AppbarImage1(
                                  imagePath: ImageConstant.imgIconnotification,
                                  margin:
                                      EdgeInsets.only(left: 19.h, right: 19.h),
                                  onTap: () {
                                    onTapIconnotificatio();
                                  }),
                              AppbarImage1(
                                  imagePath: ImageConstant.imgIconMenu,
                                  margin:
                                      EdgeInsets.only(left: 19.h, right: 19.h),
                                  onTap: () {
                                    onTapIconavatarone();
                                  })
                            ])),
                        styleType: Style.bgOutline),
                    body: SizedBox(
                        width: double.maxFinite,
                        child: Column(children: [
                          Container(
                            // frame200x8K (83:391)
                            padding: EdgeInsets.fromLTRB(9.adaptSize,
                                7.75.adaptSize, 10.adaptSize, 7.75.adaptSize),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0x33000000)),
                              color: Color(0xffffffff),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  // tinnhnQFD (83:393)
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        10.adaptSize,
                                        0.adaptSize,
                                        200.adaptSize,
                                        0.adaptSize),
                                    child: Text(
                                      'Tin nhắn',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2125,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // image3Rg7 (83:396)
                                  width: 23.adaptSize,
                                  height: 23.adaptSize,
                                  child: Image.asset(
                                    ImageConstant.iconAdd,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  decoration:
                                      AppDecoration.fillOnErrorContainer,
                                  child: Center(
                                    child: ListView(
                                      children: [
                                        Container(
                                          // frame148YQK (83:397)
                                          padding: EdgeInsets.fromLTRB(
                                              23.adaptSize,
                                              8.21.adaptSize,
                                              247.adaptSize,
                                              8.21.adaptSize),
                                          margin: EdgeInsets.fromLTRB(
                                              0.adaptSize,
                                              15.adaptSize,
                                              0.adaptSize,
                                              10.adaptSize),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0x33000000)),
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                30.adaptSize),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.adaptSize,
                                                    0.adaptSize,
                                                    10.adaptSize,
                                                    0.adaptSize),
                                                height: 20.adaptSize,
                                                child: Image.asset(
                                                  ImageConstant.iconSearchColorBlack,
                                                  width: 20.adaptSize,
                                                  height: 20.adaptSize,
                                                ),
                                              ),
                                              Text(
                                                'Tìm kiếm',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  height: 1.2175,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        (Obx(() => ListView.separated(
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 5.v);
                                            },
                                            itemCount:
                                                controller.conversations.length,
                                            itemBuilder: (context, index) {
                                              return ConversationWidget(
                                                  conversation: controller
                                                      .conversations[index]);
                                            })))
                                      ],
                                    ),
                                  )))
                        ]))));
          }
        });
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

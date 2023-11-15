import 'package:flutter_animate/flutter_animate.dart';

import '../../data/apiClient/profile_api.dart';
import '../../data/models/profile_model.dart';
import 'controller/page_notification_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_circleimage.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PageNotificationScreen extends GetWidget<PageNotificationController> {
  const PageNotificationScreen({Key? key}) : super(key: key);

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
          // Xử lý lỗi
          return Text('Error: ${snapshot.error}');
        } else {
          final fetchedProfile = snapshot.data!;
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
                  )
              )
          );
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

import 'package:flutter_animate/flutter_animate.dart';

import '../../data/apiClient/profile_api.dart';
import '../../data/models/profile_model.dart';
import '../../widgets/custom_dropdown_button.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';
import '../../data/models/userpost_item_model.dart';
import '../../widgets/userpost_item_widget.dart';
import '../../controller/page_forumone_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_circleimage.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

typedef ForumCallback = void Function(Forum selectedForum);

class PageForumoneScreen extends StatelessWidget  {

  PageForumoneScreen({Key? key}) : super(key: key);
  final PageForumoneController controller = Get.put(PageForumoneController());

  @override
  Widget build(BuildContext context) {
    // print(controller.getPostsByForumId(controller.getSelectedForum.id).value.userpostForumItemList.value[0].postContent);
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
                                url: fetchedProfile.avatarUrl,
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
                                        Obx(
                                              () => CustomImageView(
                                            url: controller.getSelectedForum.avatarUrl,
                                            height: 20.adaptSize,
                                            width: 20.adaptSize,
                                            radius: BorderRadius.circular(10.h),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.adaptSize,
                                        ),
                                        Expanded(
                                            child: DropdownButtonExample(
                                              // onForumSelected: onForumSelected,

                                            )
                                        ),
                                        CustomImageView(
                                            imagePath: ImageConstant.imgIconsearch,
                                            height: 16.adaptSize,
                                            width: 16.adaptSize,
                                            margin: EdgeInsets.only(
                                                left: 20.h, top: 2.v, bottom: 2.v)),
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
                                        Obx(
                                              () => Text(
                                            controller.getSelectedForum.modName,
                                            style: CustomTextStyles.bodyMediumBlack900,
                                          ),
                                        ),
                                        Text("lbl_moderator".tr,
                                            style: CustomTextStyles
                                                .bodySmallPrimaryContainer)
                                      ])
                                ])),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                padding: EdgeInsets.symmetric(vertical: 0),
                                decoration: AppDecoration.fillOnErrorContainer,
                                child: Obx(() {
                                  final pageForumoneModel = controller
                                      .getPostsByForumId(controller.getSelectedForum.id)
                                      .value;
                                  if (pageForumoneModel == null) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    final posts = pageForumoneModel;
                                    return ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      separatorBuilder: (context, index) => Divider(),
                                      itemCount: posts
                                          .userpostForumItemList
                                          .value.length,
                                      itemBuilder: (context, index) {
                                        UserpostItemModel model = posts
                                            .userpostForumItemList
                                            .value[index];
                                        return UserpostItemWidget(model);
                                      },
                                    );
                                  }
                                }))),
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

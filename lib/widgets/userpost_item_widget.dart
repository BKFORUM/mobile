import 'package:bkforum/data/models/data_prop/forum.dart';
import 'package:bkforum/data/models/profile_model.dart';
import 'package:bkforum/widgets/custom_comment_screen.dart';
import 'package:bkforum/widgets/image_slider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/page_post_screen/edit_post_screen.dart';
import '../presentation/page_profile_screen/page_profile_screen.dart';
import '../presentation/user_post_screen.dart';
import 'custom_reaction.dart';
import '../controller/page_feed_controller.dart';
import '../data/models/userpost_item_model.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class UserpostItemWidget extends StatelessWidget {
  UserpostItemWidget(
    this.userpostItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  UserpostItemModel userpostItemModelObj;

  var controller = Get.find<PageFeedController>();
  // ignore: non_constant_identifier_names
  final PageFeedController comments_controller = Get.put(PageFeedController());
  bool isOverflowVisible = false;

  String formatTimeDifference(Duration difference) {
    if (difference.inDays >= 1) {
      return "${difference.inDays} ngày trước";
    } else if (difference.inHours >= 1) {
      return "${difference.inHours} giờ trước";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes} phút trước";
    } else {
      return "Vừa đăng";
    }
  }

  Future<String> checkEditDeletePost() async {
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    if (userId == userpostItemModelObj.userCreateId?.value) {
      return 'userCreateId';
    } else if (userId == userpostItemModelObj.forumModId?.value) {
      return 'forumModId';
    } else {
      return 'false';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.v),
      decoration: AppDecoration.outlineGray,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.fromLTRB(
                      10.adaptSize, 26.adaptSize, 10.adaptSize, 10.adaptSize),
                  height: 220.adaptSize,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => UserPostScreen(),
                              arguments: userpostItemModelObj.id?.value,
                              transition: Transition.rightToLeft
                          );
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.h, top: 10.v),
                            child: Row(children: [
                              Icon(Icons.bubble_chart_rounded, color: Colors.blue.shade900),
                              SizedBox(width: 20.adaptSize),
                              Expanded(
                                  child: Text("Xem bài viết".tr,
                                      style: CustomTextStyles
                                          .bodyLargeInter)),
                            ])),
                      ),
                      SizedBox(height: 16.adaptSize),
                      GestureDetector(
                        onTap: () {
                          final userProfile = Profile(
                            id: userpostItemModelObj.userCreateId!.value,
                            fullName: userpostItemModelObj.userCreate!.value
                          );
                          Get.to(() => PageProfileScreen(userProfile),
                              transition: Transition.rightToLeft);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.h, top: 20.v),
                            child: Row(children: [
                              Icon(Icons.portrait_sharp, color: Colors.blue.shade900),
                              SizedBox(width: 20.adaptSize),
                              Expanded(
                                  child: Text("Xem trang cá nhân",
                                      style: CustomTextStyles
                                          .bodyLargeInter)),
                            ])),
                      ),
                      SizedBox(height: 16.adaptSize),
                      GestureDetector(
                        onTap: () {
                          final forum = Forum(id: userpostItemModelObj.forumId!.value,
                              name: userpostItemModelObj.forumName!.value,
                              modName: userpostItemModelObj.forumModName!.value);
                          Get.toNamed(
                              AppRoutes.pageForumoneScreen,
                              arguments: forum
                          );
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.h, top: 20.v),
                            child: Row(children: [
                              Icon(Icons.nature_people_rounded, color: Colors.blue.shade900),
                              SizedBox(width: 20.adaptSize),
                              Expanded(
                                  child: Text("Đến trang forum",
                                      style: CustomTextStyles
                                          .bodyLargeInter)),
                            ])),
                      ),
                    ],
                  ),
                ),
                isScrollControlled: true,
                // ignoreSafeArea: true,
              );
              // loadPost();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 0),
              decoration: AppDecoration.fillOnErrorContainer,
              child: Row(
                children: [
                  CustomImageView(
                    url: userpostItemModelObj.userAvatar!.value,
                    fit: BoxFit.cover,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    radius: BorderRadius.circular(
                      10.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.h,
                      top: 2.v,
                    ),
                    child: Text(
                      userpostItemModelObj.userCreate!.value,
                      style: CustomTextStyles.titleSmallRobotoBlack900,
                    ),
                  ),
                  (userpostItemModelObj.forumModId == userpostItemModelObj.userCreateId)
                  ? Container(
                    margin: EdgeInsets.only(left: 4.adaptSize),
                    padding: EdgeInsets.all(2.adaptSize),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: Colors.blue.shade100,),
                    child: Icon(
                        Icons
                            .admin_panel_settings_rounded,
                        size: 12.adaptSize,
                        color: Colors.blue.shade900),
                  )
                      : SizedBox.shrink(),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: 3.v),
                    child: Obx(
                      () => Text(
                        userpostItemModelObj.forumName!.value,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 8.h),
                child: Text(
                  (userpostItemModelObj.createdAt?.value != null
                      ? formatTimeDifference(DateTime.now()
                          .difference(userpostItemModelObj.createdAt!.value))
                      : "0"),
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 354.h,
              padding: EdgeInsets.symmetric(
                horizontal: 6.h,
                vertical: 2.v,
              ),
              decoration: AppDecoration.fillOnErrorContainer,
              child: Padding(
                padding: EdgeInsets.only(right: 8.h),
                child: Html(
                  data: userpostItemModelObj.postContent!.value,
                ),
              ),
            ),
          ),
          // ignore: invalid_use_of_protected_member
          ImageSlider(userpostItemModelObj.listImages!.value),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 2.v,
              width: 9.h,
              decoration: BoxDecoration(
                color: Colors.white10,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 14.h,
              top: 13.v,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomReaction(userpostItemModelObj),
                    Padding(
                      padding: EdgeInsets.only(left: 6.h),
                      child: Text(
                        "${userpostItemModelObj.countLikes?.value} yêu thích",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                            CustomCommentScreen(userpostItemModelObj.id!.value, 'posts'),
                            isScrollControlled: true,
                            ignoreSafeArea: false,
                            enableDrag: true);
                      },
                      child: Row(
                        children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgComment,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                            margin: EdgeInsets.only(left: 13.h),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6.h),
                            child: Text(
                              "${userpostItemModelObj.countComments?.value} bình luận",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FutureBuilder<String>(
                    future: checkEditDeletePost(),
                    builder: (context, snapshot) {
                      if (snapshot.data == 'userCreateId') {
                        return IconButton(
                            onPressed: () {
                              Get.bottomSheet(Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.fromLTRB(10.adaptSize,
                                      26.adaptSize, 10.adaptSize, 10.adaptSize),
                                  height: 160.adaptSize,
                                  child: Column(children: [
                                    GestureDetector(
                                      onTap: () {
                                        // print(checkEditDeletePost());
                                        Get.back();
                                        Get.to(
                                            () => EditPostScreen(
                                                userpostItemModelObj),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.h, top: 10.v),
                                          child: Row(children: [
                                            Icon(Icons.edit),
                                            SizedBox(width: 20.adaptSize),
                                            Expanded(
                                                child: Text("Chỉnh sửa",
                                                    style: CustomTextStyles
                                                        .bodyLargeInter)),
                                          ])),
                                    ),
                                    SizedBox(height: 16.adaptSize),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                        controller.deleteConfirmDialog(
                                            userpostItemModelObj.id!.value);
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.h, top: 20.v),
                                          child: Row(children: [
                                            Icon(Icons.cancel_rounded),
                                            SizedBox(width: 20.adaptSize),
                                            Expanded(
                                                child: Text("Xóa",
                                                    style: CustomTextStyles
                                                        .bodyLargeInter)),
                                          ])),
                                    ),
                                  ])));
                            },
                            icon: Icon(Icons.more_vert));
                      } else if (snapshot.data == 'forumModId') {
                        return IconButton(
                            onPressed: () {
                              Get.bottomSheet(Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.fromLTRB(10.adaptSize,
                                      26.adaptSize, 10.adaptSize, 10.adaptSize),
                                  height: 120.adaptSize,
                                  child: Column(children: [
                                    GestureDetector(
                                      onTap: () =>
                                          controller.deleteConfirmDialog(
                                              userpostItemModelObj.id!.value),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.h, top: 20.v),
                                          child: Row(children: [
                                            Icon(Icons.cancel_rounded),
                                            SizedBox(width: 20.adaptSize),
                                            Expanded(
                                                child: Text("Xóa",
                                                    style: CustomTextStyles
                                                        .bodyLargeInter)),
                                          ])),
                                    ),
                                  ])));
                            },
                            icon: Icon(Icons.more_vert));
                      } else {
                        return SizedBox(height: 48.adaptSize);
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildImage(String urlImage, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 1.adaptSize),
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );

import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/controller/page_search_controller.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:bkforum/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/models/profile_model.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_image_1.dart';
import '../page_profile_screen/page_profile_screen.dart';

// ignore: must_be_immutable
class PageSearchScreen extends GetView<PageSearchController> {
  PageSearchScreen({Key? key}) : super(key: key);

  PageSearchController searchController = PageSearchController();
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
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
                              imagePath: ImageConstant.imgIconWhiteSearch,
                              margin: EdgeInsets.only(left: 19.h, right: 19.h),
                              onTap: () {})
                          .animate()
                          .tint(color: Colors.amber)
                          .shake(),
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
                            onTapNotificationdet();
                          }),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconMenu,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconavatarone();
                          })
                    ])),
                styleType: Style.bgFill),
            body: Container(
                padding: EdgeInsets.all(14.h),
                decoration: AppDecoration.fillOnErrorContainer,
                child: Column(children: [
                  TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                      labelText: 'Tìm kiếm'.tr,
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (String value) {
                      searchController.handleSearch(value);
                    },
                  ),
                  SizedBox(height: 8.adaptSize),
                  DefaultTabController(
                      length: 2,
                      child: Expanded(
                          child: Column(children: [
                        TabBar(
                          indicatorColor: Colors.indigo,
                          tabs: [
                            Tab(
                                child: Text('Forum',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))),
                            Tab(
                                child: Text('Người dùng',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))),
                          ],
                        ),
                        Expanded(
                            child: TabBarView(children: [
                          Obx(() {
                            // ignore: invalid_use_of_protected_member
                            if (searchController.forumResults.value.isEmpty)
                              return CustomProgressIndicator();
                            else
                              return ListView.builder(
                                itemCount:
                                    // ignore: invalid_use_of_protected_member
                                    searchController.forumResults.value.length,
                                itemBuilder: (context, index) {
                                  final forum =
                                      searchController.forumResults[index];
                                  return ListTile(
                                    leading: CustomImageView(
                                      height: 36.adaptSize,
                                      width: 36.adaptSize,
                                      radius: BorderRadius.circular(9.h),
                                      fit: BoxFit.cover,
                                      url: forum.avatarUrl ??
                                          'http://res.cloudinary.com/dy7he6gby/image/upload/v1702796805/a70tpruabwfzoq819luj.jpg',
                                    ),
                                    title: Text(forum.name),
                                    onTap: () {
                                      Get.toNamed(AppRoutes.pageForumoneScreen,
                                          arguments: forum);
                                    },
                                  );
                                },
                              );
                          }),
                          Obx(() {
                            // ignore: invalid_use_of_protected_member
                            if (searchController.userResults.value.isEmpty)
                              return CustomProgressIndicator();
                            else
                              return ListView.builder(
                                itemCount:
                                    // ignore: invalid_use_of_protected_member
                                    searchController.userResults.value.length,
                                itemBuilder: (context, index) {
                                  final user =
                                      searchController.userResults[index];
                                  return ListTile(
                                    leading: CustomImageView(
                                      height: 36.adaptSize,
                                      width: 36.adaptSize,
                                      radius: BorderRadius.circular(9.h),
                                      fit: BoxFit.cover,
                                      url: user.avatarUrl ??
                                          'http://res.cloudinary.com/dy7he6gby/image/upload/v1702796805/a70tpruabwfzoq819luj.jpg',
                                    ),
                                    title: Text(user.fullName),
                                    trailing: (user.friendStatus == 'ACTIVE')
                                        ? Icon(Icons.people_outline_rounded,
                                            color: Colors.green)
                                        : SizedBox.shrink(),
                                    onTap: () {
                                      final userProfile = Profile(
                                          id: user.id, fullName: user.fullName);
                                      Get.to(
                                          () => PageProfileScreen(userProfile),
                                          transition: Transition.rightToLeft);
                                    },
                                  );
                                },
                              );
                          }),
                          // ListView.builder(
                          //     itemCount: controller.userResults.length,
                          //     itemBuilder: (context, index) {
                          //       return ListTile(
                          //         title: Text(controller.userResults[index]),
                          //       );
                          //     })
                        ]))
                      ])))
                ]))));
  }
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
    AppRoutes.pageNotificationScreen,
  );
}

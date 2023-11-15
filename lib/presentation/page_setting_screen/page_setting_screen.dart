import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/apiClient/profile_api.dart';
import '../../data/models/profile_model.dart';
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
                color: Colors.white.withOpacity(0.1),
                backgroundColor: Colors.white,
              )
          );
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
                                margin: EdgeInsets.only(left: 19.h, right: 19.h),
                                onTap: () {
                                  onTapIconnotificatio();
                                }),
                            AppbarCircleimage(
                              url: fetchedProfile.avatarUrl,
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
                            Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  padding: EdgeInsets.fromLTRB(10.adaptSize, 26.adaptSize, 10.adaptSize, 10.adaptSize),
                                                  height: 170.adaptSize,
                                                  child:  Column(
                                                  children: [
                                                    Padding(padding: EdgeInsets.only(left: 20.h, top: 20.v),child: Row(children: [
                                                      CustomImageView(
                                                          imagePath: ImageConstant.imgIconswap,
                                                          height: 20.adaptSize,
                                                          width: 20.adaptSize),
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 20.h, top: 2.adaptSize, bottom: 2.adaptSize),
                                                          child: Text("lbl_i_m_t_kh_u".tr,
                                                              style: CustomTextStyles.bodyLargeInter))
                                                    ])),
                                                    GestureDetector(
                                                        onTap: () {
                                                          onTapRowiconexitone();
                                                        },
                                                        child: Padding(
                                                            padding: EdgeInsets.only(left: 20.h, top: 40.v, bottom: 5.v),
                                                            child: Row(children: [
                                                              CustomImageView(
                                                                  imagePath: ImageConstant.imgIconexit,
                                                                  height: 20.adaptSize,
                                                                  width: 20.adaptSize),
                                                              Padding(
                                                                  padding: EdgeInsets.only(left: 20.h, top: 2.adaptSize, bottom: 2.adaptSize),
                                                                  child: Text("lbl_ng_xu_t".tr,
                                                                      style: CustomTextStyles.bodyLargeInter))
                                                            ])))
                                                  ])
                                              )
                                          );
                                          // loadPost();
                                        },

                                        child: Padding(
                                            padding: EdgeInsets.only(left: 20.h, right: 10.v, top: 4.v, bottom: 4.v),
                                            child: Row(children: [
                                              Expanded(child: SizedBox()),
                                              CustomImageView(
                                                  imagePath: ImageConstant.imgIcondrop,
                                                  height: 18.adaptSize,
                                                  width: 18.adaptSize),
                                            ])),
                                      ),
                                      SizedBox(height: 12.v),
                                      GestureDetector(
                                        onLongPress: (){
                                          Get.bottomSheet(
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  padding: EdgeInsets.fromLTRB(10.adaptSize, 26.adaptSize, 10.adaptSize, 10.adaptSize),
                                                  height: 120.adaptSize,
                                                  child:  Column(
                                                      children: [
                                                        Padding(padding: EdgeInsets.only(left: 20.h, top: 20.v),child: Row(children: [
                                                          CustomImageView(
                                                              imagePath: ImageConstant.imgIconswap,
                                                              height: 20.adaptSize,
                                                              width: 20.adaptSize),
                                                          Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: 20.h, top: 2.adaptSize, bottom: 2.adaptSize),
                                                              child: Text("Thay đổi ảnh đại diện",
                                                                  style: CustomTextStyles.bodyLargeInter))
                                                        ])),
                                                      ])
                                              )
                                          );
                                        },
                                        onTap: () {
                                          Navigator.push(context, PageRouteBuilder(
                                            opaque: false,
                                            pageBuilder: (BuildContext context, _, __) {
                                              return Scaffold(
                                                body: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context); // Đóng trang khi nhấn vào nền
                                                  },
                                                  child: Container(
                                                    color: Colors.black.withOpacity(0.5), // Màu nền mờ
                                                    child: Hero(
                                                      tag: 'avatar',
                                                      child: Center(
                                                        child: CustomImageView(
                                                          url: fetchedProfile.avatarUrl,
                                                          height: 0.6*MediaQuery.of(context).size.height, // Phóng to ảnh để lấp đầy màn hình
                                                          width: 0.6*MediaQuery.of(context).size.width,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ).animate().fadeIn(curve: Curves.easeIn, duration: 150.ms);
                                            },
                                          ));
                                        },
                                        child: CustomImageView(
                                            url: fetchedProfile.avatarUrl,
                                            height: 70.adaptSize,
                                            width: 70.adaptSize,
                                            radius: BorderRadius.circular(35.adaptSize)),
                                      ),
                                      SizedBox(height: 13.v),
                                      Text(fetchedProfile!.fullName,
                                          style: CustomTextStyles.titleMedium18),
                                      ExpandableListExample()
                                    ])),

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
  onTapRowiconexitone() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('accessToken', '');
    preferences.setBool('isLoggedIn', false);
    Get.toNamed(
      AppRoutes.pageLoginScreen,
    );
  }
}

class ExpandableListExample extends StatefulWidget {
  const ExpandableListExample({Key? key}) : super(key: key);

  @override
  _ExpandableListExampleState createState() => _ExpandableListExampleState();
}

class _ExpandableListExampleState extends State<ExpandableListExample> {
  List<ExpansionPanelItem> _expansionPanelItems = [
    ExpansionPanelItem(
      header: 'Hồ sơ',
      body: Container(
        child: Text('Content of Panel 1'),
      ),
      isExpanded: false,
    ),
    ExpansionPanelItem(
      header: 'Công cụ',
      body: Container(
        child: Text('Content of Panel 2'),
      ),
      isExpanded: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return
      ExpansionPanelList(
        elevation: 1,
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _expansionPanelItems[index].isExpanded = !isExpanded;
          });
        },
        children: _expansionPanelItems.map<ExpansionPanel>((ExpansionPanelItem item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.header),
              );
            },
            body: item.body,
            isExpanded: item.isExpanded,
          );
        }).toList(),
      );
  }
}

class ExpansionPanelItem {
  ExpansionPanelItem({
    required this.header,
    required this.body,
    this.isExpanded = false,
  });

  String header;
  Widget body;
  bool isExpanded;
}

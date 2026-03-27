import 'package:bkforum/presentation/page_forumone_screen/page_add_forum.dart';
import 'package:bkforum/widgets/progress_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/apiClient/forum_list_api.dart';
import '../../data/apiClient/profile_api.dart';
import '../../data/models/data_prop/forum.dart';
import '../../data/models/profile_model.dart';
import '../../controller/page_setting_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageSettingScreen extends GetWidget<PageSettingController> {
  PageSettingScreen({Key? key}) : super(key: key);

  Future<SharedPreferences> preferencesFuture = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return FutureBuilder<Profile>(
        future: ProfileApi().fetchProfile(''),
        // future: controller.openProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomProgressIndicator();
          } else if (snapshot.hasError) {
            // Xử lý lỗi
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
                          margin: EdgeInsets.only(
                              left: 24.h, top: 15.v, bottom: 15.v),
                          onTap: () {
                            onTapIconhomeone();
                          },
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
                                  margin:
                                      EdgeInsets.only(left: 19.h, right: 19.h),
                                  onTap: () {
                                    onTapIconmessageone();
                                  }),
                              AppbarImage1(
                                  imagePath: ImageConstant.imgIconnotification,
                                  margin:
                                      EdgeInsets.only(left: 19.h, right: 19.h),
                                  onTap: () {
                                    onTapIconnotificatio();
                                  }),
                              AppbarImage1(
                                      imagePath: ImageConstant.imgIconMenu,
                                      margin: EdgeInsets.only(
                                          left: 19.h, right: 19.h),
                                      onTap: () {})
                                  .animate()
                                  .tint(color: Colors.amber)
                                  .shake(),
                            ])),
                        styleType: Style.bgOutline),
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
                                        Get.bottomSheet(Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                10.adaptSize,
                                                26.adaptSize,
                                                10.adaptSize,
                                                10.adaptSize),
                                            height: 170.adaptSize,
                                            child: Column(children: [
                                              GestureDetector(
                                                onTap: (){
                                                  Get.back();
                                                  final passwordController = TextEditingController();
                                                  final confirmPasswordController = TextEditingController();
                                                  final newPasswordController = TextEditingController();

                                                  RxBool isPasswordVisible = true.obs;
                                                  RxBool isConfirmPasswordVisible = true.obs;
                                                  RxBool isNewPasswordVisible = true.obs;

                                                  Get.defaultDialog(
                                                    title: 'Đổi mật khẩu',
                                                    content: Column(
                                                      children: [
                                                        Obx(() {
                                                            return TextField(
                                                              controller: passwordController,
                                                              keyboardType: TextInputType.visiblePassword,
                                                              obscureText: isPasswordVisible.value,
                                                              decoration: InputDecoration(
                                                                hintText: 'Mật khẩu cũ',
                                                                suffixIcon: IconButton(
                                                                  icon: Icon(
                                                                    isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                                                                  ),
                                                                  onPressed: () {
                                                                      isPasswordVisible.value = !isPasswordVisible.value;
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        ),
                                                        Obx(() {
                                                            return TextField(
                                                              controller: confirmPasswordController,
                                                              keyboardType: TextInputType.visiblePassword,
                                                              obscureText: isConfirmPasswordVisible.value,
                                                              decoration: InputDecoration(
                                                                  hintText: 'Nhập lại mật khẩu cũ',
                                                                suffixIcon: IconButton(
                                                                  icon: Icon(
                                                                    isConfirmPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                                                                  ),
                                                                  onPressed: () {
                                                                    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        ),
                                                        Obx(() {
                                                            return TextField(
                                                              controller: newPasswordController,
                                                              keyboardType: TextInputType.visiblePassword,
                                                              obscureText: isNewPasswordVisible.value,
                                                              decoration: InputDecoration(hintText: 'Nhập mật khẩu mới',
                                                                suffixIcon: IconButton(
                                                                  icon: Icon(
                                                                    isNewPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                                                                  ),
                                                                  onPressed: () {
                                                                    isNewPasswordVisible.value = !isNewPasswordVisible.value;
                                                                  },
                                                                )),
                                                            );
                                                          }
                                                        ),
                                                      ],
                                                    ),
                                                    confirm: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.all(30.adaptSize),
                                                      ),
                                                      child: Text('OK', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber)),
                                                      onPressed: () {
                                                        String password = passwordController.text.trim();
                                                        String confirmPassword = confirmPasswordController.text.trim();
                                                        String newPassword = newPasswordController.text.trim();
                                                        if(password == confirmPassword && password != newPassword){
                                                          controller.changePassword(confirmPassword, newPassword);
                                                        } else Get.snackbar('Lỗi nhập liệu', 'Xác nhận mật khẩu chưa chính xác', backgroundColor: Colors.red.shade300);
                                                      },
                                                    ),
                                                    cancel: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.all(30.adaptSize),
                                                      ),
                                                      child: Text('Hủy', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber)),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                    ),
                                                  );
                                                  },
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.h, top: 20.v),
                                                    child: Row(children: [
                                                      CustomImageView(
                                                          imagePath: ImageConstant
                                                              .imgIconswap,
                                                          height: 20.adaptSize,
                                                          width: 20.adaptSize),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20.h,
                                                                  top:
                                                                      2.adaptSize,
                                                                  bottom: 2
                                                                      .adaptSize),
                                                          child: Text(
                                                              "lbl_i_m_t_kh_u".tr,
                                                              style: CustomTextStyles
                                                                  .bodyLargeInter))
                                                    ])),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    onTapRowiconexitone();
                                                  },
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.h,
                                                          top: 40.v,
                                                          bottom: 5.v),
                                                      child: Row(children: [
                                                        CustomImageView(
                                                            imagePath:
                                                                ImageConstant
                                                                    .imgIconexit,
                                                            height:
                                                                20.adaptSize,
                                                            width:
                                                                20.adaptSize),
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                left: 20.h,
                                                                top:
                                                                    2.adaptSize,
                                                                bottom: 2
                                                                    .adaptSize),
                                                            child: Text(
                                                                "lbl_ng_xu_t"
                                                                    .tr,
                                                                style: CustomTextStyles
                                                                    .bodyLargeInter))
                                                      ])))
                                            ])));
                                        // loadPost();
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.h,
                                              right: 10.v,
                                              top: 4.v,
                                              bottom: 4.v),
                                          child: Row(children: [
                                            Expanded(child: SizedBox()),
                                            CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgIcondrop,
                                                height: 18.adaptSize,
                                                width: 18.adaptSize),
                                          ])),
                                    ),
                                    SizedBox(height: 12.v),
                                    GestureDetector(
                                      onLongPress: () {
                                        Get.bottomSheet(Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                10.adaptSize,
                                                26.adaptSize,
                                                10.adaptSize,
                                                10.adaptSize),
                                            height: 120.adaptSize,
                                            child: Column(children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.h, top: 20.v),
                                                  child: Row(children: [
                                                    CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgIconswap,
                                                        height: 20.adaptSize,
                                                        width: 20.adaptSize),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20.h,
                                                                top:
                                                                    2.adaptSize,
                                                                bottom: 2
                                                                    .adaptSize),
                                                        child: Text(
                                                            "Thay đổi ảnh đại diện",
                                                            style: CustomTextStyles
                                                                .bodyLargeInter))
                                                  ])),
                                            ])));
                                      },
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder:
                                                  (BuildContext context, _,
                                                      __) {
                                                return Scaffold(
                                                  body: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      child: Hero(
                                                        tag: 'avatar',
                                                        child: Center(
                                                          child:
                                                              CustomImageView(
                                                            url: fetchedProfile
                                                                .avatarUrl,
                                                            height: 0.6 *
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                            width: 0.6 *
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ).animate().fadeIn(
                                                    curve: Curves.easeIn,
                                                    duration: 150.ms);
                                              },
                                            ));
                                      },
                                      child: CustomImageView(
                                          url: fetchedProfile.avatarUrl,
                                          height: 70.adaptSize,
                                          width: 70.adaptSize,
                                          fit: BoxFit.cover,
                                          radius: BorderRadius.circular(
                                              35.adaptSize)),
                                    ),
                                    SizedBox(height: 13.v),
                                    Text(fetchedProfile.fullName,
                                        style: CustomTextStyles.titleMedium18),
                                    ListView(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.person,
                                                color: Colors.orangeAccent),
                                            title: Text('Hồ sơ'),
                                            onTap: () {
                                              controller.onTapCheckProfile(
                                                  fetchedProfile);
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.people,
                                                color: Colors.blueAccent),
                                            title: Text('Bạn bè'),
                                            onTap: () {
                                              controller.onTapOpenFriendPage();
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.event,
                                                color: Colors.green),
                                            title: Text('Sự kiện'),
                                            onTap: () {
                                              controller.onTapOpenEventPage();
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.forum,
                                                color: Colors.pinkAccent),
                                            title: Text('Forum'),
                                            trailing: IconButton(
                                              onPressed: () {
                                                Get.to(() => PageAddForum(),
                                                  transition: Transition.rightToLeft
                                                );
                                              },
                                              icon: Icon(Icons
                                                  .add_circle_outline_rounded),
                                            ),
                                          ),
                                          FutureBuilder<List<Forum>>(
                                            future: ForumListApiClient().fetchForums(fetchedProfile.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                final fetchedForum = snapshot.data;
                                                return Container(
                                                  height: 140.adaptSize,
                                                  margin: EdgeInsets.only(left: 50.adaptSize),
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: fetchedForum?.length,
                                                      itemBuilder: (context, index) {
                                                        final forum = fetchedForum?[index];
                                                        return GestureDetector(
                                                          onTap: (){
                                                            Get.toNamed(
                                                              AppRoutes.pageForumoneScreen,
                                                              arguments: forum
                                                            );
                                                          },
                                                          child: Container(
                                                              height: 136.adaptSize,
                                                              width: 130.adaptSize,
                                                              margin: EdgeInsets.all(8),
                                                              padding: EdgeInsets.all(4),
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black12),
                                                                color: (fetchedProfile.id != forum?.modId) ? Colors.grey.shade50 : Colors.blue.shade100,
                                                                borderRadius: BorderRadius.circular(20),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.grey.withOpacity(0.5),
                                                                    spreadRadius: 2,
                                                                    blurRadius: 5,
                                                                    offset: Offset(0, 3)
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Center(
                                                                child: Column(
                                                                    children: [
                                                                      CustomImageView(
                                                                        height: 70.adaptSize,
                                                                        width: 70.adaptSize,
                                                                        url: forum!.avatarUrl ?? 'http://res.cloudinary.com/dy7he6gby/image/upload/v1702796805/a70tpruabwfzoq819luj.jpg' ,
                                                                        fit: BoxFit.cover,
                                                                        radius: BorderRadius.all(Radius.circular(12)),
                                                                      ),
                                                                      SizedBox(height: 8),
                                                                      Text(
                                                                          forum.name,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          maxLines: 2,
                                                                          textAlign: TextAlign.center,
                                                                          style: TextStyle(color: Colors.black87)),
                                                                    ]),
                                                              )),
                                                        );
                                                      }),
                                                );
                                              } else{
                                                return SizedBox.shrink();
                                              }
                                            }
                                          ),
                                          // ListTile(
                                          //   leading: Icon(Icons.text_snippet_rounded, color: Colors.orange),
                                          //   title: Text('Bài viết'),
                                          // ),
                                        ])
                                  ])),
                            ]))));
          }
        });
  }

  /// Navigates to the pageFeedScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageFeedScreen.
  onTapIconhomeone() {
    Get.toNamed(
      AppRoutes.pageFeedScreen,
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

  onTapRowiconexitone() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('accessToken', '');
    await preferences.setString('refreshToken', '');
    await preferences.setBool('isLoggedIn', false);
    Get.offAllNamed(
      AppRoutes.pageLoginScreen,
    );
  }
}

import 'dart:io';

import 'package:bkforum/presentation/page_notification_screen/page_notification_screen.dart';
import 'package:bkforum/widgets/delete_stateful_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/page_post_controller.dart';
import 'package:bkforum/core/app_export.dart';

import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:bkforum/widgets/custom_elevated_button.dart';
import 'package:bkforum/widgets/custom_dropdown_button.dart';
import 'package:flutter/material.dart';

import '../../data/models/data_prop/forum.dart';

String textFieldValue = '';
String anchorTag = '';
int statusCode = 401;
final RxList<File> selectedImages = RxList<File>();

// ignore: must_be_immutable
class PagePostScreen extends GetWidget<PagePostController> {
  PagePostScreen({Key? key}) : super(key: key);
  final PagePostController controller = Get.put(PagePostController());

  TextEditingController displayTextController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forum = Get.arguments as Forum?;
    // print(forum?.name);
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
                          onTap: () {
                            onTapIconsearch();
                          }),
                      AppbarImage1(
                              imagePath: ImageConstant.imgIconadd,
                              margin: EdgeInsets.only(left: 19.h, right: 19.h))
                          .animate()
                          .tint(color: Colors.amber)
                          .shake(),
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
                            onTapIconnotificatio();
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
                width: 359.h,
                padding: EdgeInsets.all(14.h),
                decoration: AppDecoration.fillOnErrorContainer,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(top: 17.v, bottom: 16.v),
                              child: Text("Bài viết".tr,
                                  style:
                                      CustomTextStyles.titleMediumHelvetica18)),
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 0.v),
                          decoration: AppDecoration.fillOnErrorContainer,
                          child: CustomElevatedButton(
                              text: "lbl_ng".tr,
                              buttonTextStyle: CustomTextStyles
                                  .titleMediumHelveticaOnPrimaryContainer,
                              buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shadowColor: Colors.white,
                              ),
                              onTap: () {
                                // print('forumId: ${Get.find<PagePostController>().getSelectedForum.id}');
                                final postId = (Get.find<PagePostController>().getSelectedForum.id == 'default id')
                                    ? forum?.id
                                    : Get.find<PagePostController>().getSelectedForum.id;
                                controller.uploadPost(
                                    context,
                                    postId!,
                                    textFieldValue);
                                onTapIconhomeone();
                              }),
                        ))
                      ]),
                      SizedBox(height: 14.v),
                      if(forum?.id == null)
                      DropdownButtonExample()
                      else Container(
                        margin: EdgeInsets.symmetric(vertical: 8.adaptSize),
                        padding: EdgeInsets.all(18.adaptSize),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20.adaptSize),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                forum!.name,
                                style: TextStyle(fontSize: 18.adaptSize),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 4.h, top: 8.v),
                          child: TextFormField(
                            maxLines: 25,
                            onChanged: (value) {
                              textFieldValue = value;
                            },
                          )),
                      Spacer(),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 1.v),
                          decoration: AppDecoration.fillGray200.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgIconimage,
                                    height: 20.adaptSize,
                                    width: 20.adaptSize,
                                  )),
                              SizedBox(width: 16),
                              Flexible(
                                child: CustomElevatedButton(
                                    width: 60.h,
                                    text: "lbl_h_nh_nh".tr,
                                    buttonTextStyle: CustomTextStyles
                                        .titleMediumHelveticaOnPrimaryContainer,
                                    buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          barrierColor:
                                              Colors.black87.withOpacity(0.8),
                                          builder: (BuildContext context) {
                                            return Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10.adaptSize,
                                                  16.adaptSize,
                                                  10.adaptSize,
                                                  10.adaptSize),
                                              height: 700.adaptSize,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                children: [
                                                  CustomElevatedButton(
                                                    text: "Chọn từ thư viện".tr,
                                                    buttonStyle: ElevatedButton
                                                        .styleFrom(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 7
                                                                        .adaptSize),
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            alignment: Alignment
                                                                .center),
                                                    buttonTextStyle: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 18.fSize,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    onTap: () async {
                                                      final pickedImage =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                      // final pickedImagePath = pickedImage?.path;
                                                      final selectedImage =
                                                          File(pickedImage!
                                                              .path);
                                                      // ignore: invalid_use_of_protected_member
                                                      selectedImages.value
                                                          .add(selectedImage);
                                                    },
                                                  ).animate().fade().slideY(
                                                      curve: Curves.easeIn),
                                                  CustomElevatedButton(
                                                    text: "Chọn từ máy ảnh".tr,
                                                    buttonStyle: ElevatedButton
                                                        .styleFrom(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 7
                                                                        .adaptSize),
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            alignment: Alignment
                                                                .center),
                                                    buttonTextStyle: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 18.fSize,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    onTap: () async {
                                                      // Navigator.pop(context);
                                                      final pickedImage =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);
                                                      setState(() {
                                                        if (pickedImage !=
                                                            null) {
                                                          final selectedImage =
                                                              File(pickedImage
                                                                  .path);
                                                          // ignore: invalid_use_of_protected_member
                                                          selectedImages.value.add(
                                                              selectedImage);
                                                        } else {
                                                          print(
                                                              'No image selected.');
                                                        }
                                                      });
                                                    },
                                                  ).animate().fade().slideY(
                                                      curve: Curves.easeIn),
                                                  const SizedBox(height: 20),
                                                  // selectedImages.isNotEmpty ? Text("Okeee"): const Text("Chưa có ảnh"),
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Obx(() {
                                                        // ignore: invalid_use_of_protected_member
                                                        if (selectedImages.value.isNotEmpty) {
                                                          return ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            // ignore: invalid_use_of_protected_member
                                                            itemCount: selectedImages.value.length,
                                                            itemBuilder: (context, index) {
                                                              // ignore: invalid_use_of_protected_member
                                                              File image = selectedImages.value[index];
                                                              return Stack(
                                                                children: [
                                                                  CustomImageView(
                                                                    file: image,
                                                                    width: 0.6 * MediaQuery.of(context).size.height,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                  Positioned(
                                                                    top: 6,
                                                                    right: 6,
                                                                    child: CancelButton(
                                                                      onPressed: () {
                                                                        // ignore: invalid_use_of_protected_member
                                                                        selectedImages.value.remove(image);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          return Container(
                                                            child: Center(
                                                              child: CustomImageView(
                                                                imagePath: ImageConstant.imageNotFound,
                                                                width: 120,
                                                                height: 120,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }),
                                                    ),
                                                  ),
                                                  CustomElevatedButton(
                                                    text: "Chọn".tr,
                                                    onTap: () {
                                                      // print(selectedImages.value
                                                      //     .length);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }),
                              ),
                            ],
                          )),
                      SizedBox(height: 10.v),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 1.v),
                        decoration: AppDecoration.fillGray200.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10.h),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgIconlink,
                                  height: 20.adaptSize,
                                  width: 20.adaptSize,
                                )),
                            SizedBox(width: 12),
                            Flexible(
                              child: CustomElevatedButton(
                                  width: 60.h,
                                  text: "lbl_li_n_k_t".tr,
                                  buttonTextStyle: CustomTextStyles
                                      .titleMediumHelveticaOnPrimaryContainer,
                                  buttonStyle: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    // maximumSize: Size.square(2)
                                  ),
                                  onTap: () {
                                    Get.bottomSheet(
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 20, 10, 10),
                                        height: 300.adaptSize,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: displayTextController,
                                              decoration: InputDecoration(
                                                labelText: 'Văn bản hiển thị',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            TextField(
                                              controller: linkController,
                                              decoration: InputDecoration(
                                                labelText: 'Liên kết gốc',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            SizedBox(height: 70.adaptSize),
                                            CustomElevatedButton(
                                                onTap: () {
                                                  String displayText =
                                                      displayTextController
                                                          .text;
                                                  String link =
                                                      linkController.text;
                                                  displayTextController.text =
                                                      '';
                                                  linkController.text = '';
                                                  anchorTag =
                                                      '<a href="$link">$displayText</a>';
                                                },
                                                text: 'Thêm vào bài viết'.tr)
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16.v)
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

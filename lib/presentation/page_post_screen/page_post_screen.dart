// import 'dart:html';


import 'package:bkforum/presentation/page_notification_screen/page_notification_screen.dart';
import 'package:bkforum/widgets/base_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';

import 'controller/page_post_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/app_bar/appbar_circleimage.dart';
import 'package:bkforum/widgets/app_bar/appbar_image.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_1.dart';
import 'package:bkforum/widgets/app_bar/appbar_image_2.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:bkforum/widgets/custom_elevated_button.dart';
import 'package:bkforum/widgets/custom_dropdown_button.dart';
import 'package:bkforum/widgets/custom_text_form_field.dart';
import 'package:bkforum/widgets/modal_select_image.dart';
import 'package:flutter/material.dart';

class PagePostScreen extends GetWidget<PagePostController> {
  const PagePostScreen({Key? key}) : super(key: key);

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
                          margin: EdgeInsets.only(left: 19.h, right: 19.h)
                      ).animate().tint(color: Colors.amber).shake(),
                      AppbarImage1(
                          imagePath: ImageConstant.imgIconnotification,
                          margin: EdgeInsets.only(left: 19.h, right: 19.h),
                          onTap: () {
                            onTapIconnotificatio();
                          }),
                      AppbarCircleimage(
                          imagePath: ImageConstant.imgIconavatar,
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
                              child: Text("lbl_t_o_b_i_vi_t".tr,
                                  style:
                                      CustomTextStyles.titleMediumHelvetica18)),
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 0.v),
                              decoration: AppDecoration.fillOnErrorContainer,
                              child: CustomElevatedButton(
                                  text: "lbl_ng".tr,
                                  buttonTextStyle: CustomTextStyles.titleMediumHelveticaOnPrimaryContainer,
                                  buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor:  Colors.white,
                                  ),
                                  onTap: (){
                                    Get.offNamed(AppRoutes.pageFeedScreen);
                                  }
                              ),
                              // Text("lbl_ng".tr,
                              //     style: CustomTextStyles
                              //         .titleMediumHelveticaOnPrimaryContainer)),
                          )
                        )
                      ]),
                      SizedBox(height: 14.v),
                      DropdownButtonExample(
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 4.h, top: 8.v),
                          child:
                            CustomTextFormField(
                              hintText: "msg_vi_t_b_i_t_i_y".tr,
                              borderDecoration: InputBorder.none,
                              maxLines: 20,
                          )
                      ),
                          // Text("msg_vi_t_b_i_t_i_y".tr,
                          //                           style:
                          //                               CustomTextStyles.bodyLargePrimaryContainer)),
                      Spacer(),

                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 1.v),
                          decoration: AppDecoration.fillGray200.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder13),
                          child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 10.h),
                                      child: CustomImageView(
                                        imagePath: ImageConstant.imgIconimage,
                                        height: 20.adaptSize,
                                        width: 20.adaptSize,
                                      )
                                  ),

                                  SizedBox(width: 16),
                                  Flexible(
                                      child: CustomElevatedButton(
                                          width: 60.h,
                                          text: "lbl_h_nh_nh".tr,
                                          buttonTextStyle: CustomTextStyles.titleMediumHelveticaOnPrimaryContainer,
                                          buttonStyle: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              shadowColor:  Colors.transparent,
                                              // maximumSize: Size.square(2)
                                          ),
                                          onTap: (){
                                              List<String> selectedImages = [];
                                              showModalBottomSheet(
                                                  context: context,
                                                  isDismissible: true,
                                                  barrierColor: Colors.black87.withOpacity(0.8),
                                                  builder: (BuildContext context) {
                                                      return  Container(
                                                        padding: EdgeInsets.fromLTRB(10.adaptSize, 26.adaptSize, 10.adaptSize, 10.adaptSize),
                                                        height: 700.adaptSize,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Animate(
                                                              effects: [FadeEffect(), SlideEffect(curve: Curves.easeIn)],
                                                              child: CustomElevatedButton(
                                                                  text: "Chọn từ thư viện".tr,
                                                                  buttonStyle: ElevatedButton.styleFrom(
                                                                    backgroundColor: Colors.transparent,
                                                                    shadowColor:  Colors.transparent,
                                                                      alignment: Alignment.topLeft
                                                                  ),
                                                                  buttonTextStyle: TextStyle(
                                                                      color: Colors.black87,
                                                                      fontSize: 18.fSize,
                                                                      fontFamily: 'Roboto',
                                                                    fontWeight: FontWeight.w600
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                ),
                                                            ),
                                                            CustomElevatedButton(
                                                              text: "Chọn từ máy ảnh".tr,
                                                              buttonStyle: ElevatedButton.styleFrom(
                                                                backgroundColor: Colors.transparent,
                                                                shadowColor:  Colors.transparent,
                                                                alignment: Alignment.topLeft
                                                              ),
                                                              buttonTextStyle: TextStyle(
                                                                color: Colors.black87,
                                                                fontSize: 18.fSize,
                                                                  fontFamily: 'Roboto',
                                                                  fontWeight: FontWeight.w600
                                                              ),
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                            ).animate().fade().slideY(curve: Curves.easeIn),
                                                            const SizedBox(height: 20),
                                                            //selectedImage != null ? Image.file(selectedImage!) : const Text("Chưa có ảnh");
                                                            CustomElevatedButton(
                                                              text: "Chọn".tr,
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                  });}
                                      ),
                                  ),
                                  ],
                              )
                      ),
                      SizedBox(height: 10.v),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 1.v),
                        decoration: AppDecoration.fillGray200.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder13),
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10.h),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgIconlink,
                                  height: 20.adaptSize,
                                  width: 20.adaptSize,
                                )
                            ),

                            SizedBox(width: 12),
                            Flexible(
                              child: CustomElevatedButton(
                                  width: 60.h,
                                  text: "lbl_li_n_k_t".tr,
                                  buttonTextStyle: CustomTextStyles.titleMediumHelveticaOnPrimaryContainer,
                                  buttonStyle: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor:  Colors.transparent,
                                    // maximumSize: Size.square(2)
                                  ),
                                  onTap: (){
                                    Get.offNamed(AppRoutes.pageFeedScreen);
                                  }
                              ),
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 16.v)
                    ]))));
  }


  //dynamic selectedImage ;
  // Future pickImageFromGallery() async{
  //     final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     setState(() {
  //       selectedImage = File(returnedImage!.path as List<Object>);
  //     });
  // }


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

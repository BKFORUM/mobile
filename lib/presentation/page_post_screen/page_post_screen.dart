

// import 'dart:html';
import 'dart:io';
import 'package:bkforum/presentation/page_feed_screen/models/data_prop/post_data.dart';
import 'package:bkforum/presentation/page_notification_screen/page_notification_screen.dart';
import 'package:bkforum/widgets/base_button.dart';
import 'package:bkforum/widgets/delete_stateful_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/apiClient/profile_api.dart';
import '../../data/apiClient/upload_image.dart';
import '../../data/models/profile_model.dart';
import '../page_feed_screen/models/data_prop/document.dart';
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
List<File> selectedImages = [];

class PagePostScreen extends GetWidget<PagePostController> {

  PagePostScreen({Key? key}) : super(key: key);
  final PagePostController controller = Get.put(PagePostController());

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
      // print(fetchedProfile?.fullName);
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
                  resizeToAvoidBottomInset: true,
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
                                url: fetchedProfile.avatarUrl,
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
                                          // print('forumId: ${Get.find<PagePostController>().getSelectedForum.id}');
                                          uploadPost(Get.find<PagePostController>().getSelectedForum.id);
                                        }
                                    ),
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
                                          ),
                                          onTap: (){

                                            showModalBottomSheet(
                                                context: context,
                                                isDismissible: true,
                                                isScrollControlled: true,
                                                barrierColor: Colors.black87.withOpacity(0.8),
                                                builder: (BuildContext context) {
                                                  return  Container(
                                                    padding: EdgeInsets.fromLTRB(10.adaptSize, 16.adaptSize, 10.adaptSize, 10.adaptSize),
                                                    height: 700.adaptSize,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        CustomElevatedButton(
                                                            text: "Chọn từ thư viện".tr,
                                                            buttonStyle: ElevatedButton.styleFrom(
                                                                padding: EdgeInsets.only(top: 7.adaptSize),
                                                                backgroundColor: Colors.transparent,
                                                                shadowColor:  Colors.transparent,
                                                                alignment: Alignment.center
                                                            ),
                                                            buttonTextStyle: TextStyle(
                                                                color: Colors.black87,
                                                                fontSize: 18.fSize,
                                                                fontFamily: 'Roboto',
                                                                fontWeight: FontWeight.w600
                                                            ),
                                                            onTap: () async {
                                                              final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                              // final pickedImagePath = pickedImage?.path;
                                                              final selectedImage = File(pickedImage!.path);
                                                              selectedImages.add(selectedImage);
                                                            },
                                                          ).animate().fade().slideY(curve: Curves.easeIn),
                                                        CustomElevatedButton(
                                                          text: "Chọn từ máy ảnh".tr,
                                                          buttonStyle: ElevatedButton.styleFrom(
                                                              padding: EdgeInsets.only(top: 7.adaptSize),
                                                              backgroundColor: Colors.transparent,
                                                              shadowColor:  Colors.transparent,
                                                              alignment: Alignment.center
                                                          ),
                                                          buttonTextStyle: TextStyle(
                                                              color: Colors.black87,
                                                              fontSize: 18.fSize,
                                                              fontFamily: 'Roboto',
                                                              fontWeight: FontWeight.w600
                                                          ),
                                                          onTap: () async {
                                                            // Navigator.pop(context);
                                                            final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                                                            setState(() {
                                                              if (pickedImage != null) {
                                                                final selectedImage = File(pickedImage.path);
                                                                selectedImages.add(selectedImage);
                                                              } else {
                                                                print('No image selected.');
                                                              }
                                                            });
                                                          },
                                                        ).animate().fade().slideY(curve: Curves.easeIn),
                                                        const SizedBox(height: 20),
                                                        // selectedImages.isNotEmpty ? Text("Okeee"): const Text("Chưa có ảnh"),
                                                        Expanded(
                                                          child: SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                if (selectedImages.isNotEmpty)
                                                                  ListView.builder(
                                                                    shrinkWrap: true,
                                                                    physics: NeverScrollableScrollPhysics(),
                                                                    itemCount: selectedImages.length,
                                                                    itemBuilder: (context, index) {
                                                                      File image = selectedImages[index];
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
                                                                                selectedImages.remove(image);
                                                                                // setState(() {
                                                                                //   print("Đã xóa");
                                                                                //    // Xóa hình ảnh khỏi danh sách
                                                                                // });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                if (selectedImages.isEmpty)
                                                                  Container(
                                                                    child: Center(
                                                                      child: CustomImageView(
                                                                        imagePath: ImageConstant.imageNotFound,
                                                                        width: 120,
                                                                        height: 120,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        CustomElevatedButton(
                                                          text: "Chọn".tr,
                                                          onTap: () {
                                                            print(selectedImages.length);
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

      }
    );
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

  void uploadPost(String forumId) {
// Comment để thư code
    List<PostDocument> documents = [];

    if (selectedImages.isNotEmpty) {
      for (final File selectedImage in selectedImages) {
        uploadImage(selectedImage).then((document) {
          documents.add(document);

          if (documents.length == selectedImages.length) {
            for (final PostDocument document in documents) {
              print('fileUrl: ${document.fileUrl}');
              print('fileName: ${document.fileName}');
            }
          }
        });
      }
    }
    print(forumId);

  }
}

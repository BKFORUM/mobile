import 'package:bkforum/data/models/data_prop/document.dart';
import 'package:bkforum/data/models/userpost_item_model.dart';
import 'package:flutter/material.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controller/page_post_controller.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/delete_stateful_button.dart';

// ignore: must_be_immutable
class EditPostScreen extends StatelessWidget {
  EditPostScreen(this.userpostItemModelObj, {Key? key}) : super(key: key);

  final UserpostItemModel userpostItemModelObj;
  String textFieldValue = '';
  String anchorTag = '';
  int statusCode = 401;
  RxList<File> selectedImages = RxList<File>();

  final PagePostController controller = Get.put(PagePostController());

  TextEditingController contentTextController = TextEditingController();
  TextEditingController displayTextController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    contentTextController.text = userpostItemModelObj.postContent!.value
        .replaceAll(RegExp(r"<.*?>"), "");
    textFieldValue = userpostItemModelObj.postContent!.value;
    RxList<PostDocument>? availableImages = userpostItemModelObj.document;
    RxList<dynamic> allImages = RxList<dynamic>();
    allImages.addAll(selectedImages);
    if (availableImages != null) allImages.addAll(availableImages);
    RxBool isLoading = false.obs;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Chỉnh sửa bài viết'),
      ),
      body: Container(
          width: 359.h,
          padding: EdgeInsets.all(14.h),
          decoration: AppDecoration.fillOnErrorContainer,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 17.v, bottom: 16.v),
                    child: Text("Bài viết".tr,
                        style: CustomTextStyles.titleMediumHelvetica18)),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 0.v),
                decoration: AppDecoration.fillOnErrorContainer,
                child: CustomElevatedButton(
                    text: "Lưu".tr,
                    buttonTextStyle:
                        CustomTextStyles.titleMediumHelveticaOnPrimaryContainer,
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.white,
                    ),
                    leftIcon: Obx(() {
                      return isLoading.value
                          ? Container(
                              padding: const EdgeInsets.only(right: 12.0),
                              height: 14.adaptSize,
                              width: 26.adaptSize,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            )
                          : Container();
                    }),
                    onTap: () {
                      isLoading.value = true;
                      controller
                          .editPost(context, userpostItemModelObj.id,
                              textFieldValue, allImages)
                          .then((_) {
                        isLoading.value = false;
                        Get.toNamed(AppRoutes.pageFeedScreen);
                      });
                    }),
              ))
            ]),
            Container(
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
                      userpostItemModelObj.forumName!.value,
                      style: TextStyle(fontSize: 18.adaptSize),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 4.h, top: 8.v),
                child: TextFormField(
                  controller: contentTextController,
                  maxLines: 26,
                  onChanged: (value) {
                    textFieldValue = value;
                  },
                )),
            Spacer(),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 1.v),
                decoration: AppDecoration.fillGray200
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListTile(
                          leading: CustomImageView(
                            imagePath: ImageConstant.imgIconimage,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                          ),
                          title: Text(
                            "lbl_h_nh_nh".tr,
                            style: CustomTextStyles
                                .titleMediumHelveticaOnPrimaryContainer,
                          ),
                          horizontalTitleGap: 0,
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isDismissible: true,
                                isScrollControlled: true,
                                barrierColor: Colors.black87.withOpacity(0.8),
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
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(children: [
                                      CustomElevatedButton(
                                        text: "Chọn từ thư viện".tr,
                                        buttonStyle: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.only(
                                                top: 7.adaptSize),
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            alignment: Alignment.center),
                                        buttonTextStyle: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.fSize,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600),
                                        onTap: () async {
                                          final pickedImage =
                                              await ImagePicker().pickImage(
                                                  source: ImageSource.gallery);
                                          // final pickedImagePath = pickedImage?.path;
                                          final selectedImage =
                                              File(pickedImage!.path);
                                          // selectedImages.value
                                          //     .add(selectedImage);
                                          allImages.add(selectedImage);
                                        },
                                      )
                                          .animate()
                                          .fade()
                                          .slideY(curve: Curves.easeIn),
                                      CustomElevatedButton(
                                        text: "Chọn từ máy ảnh".tr,
                                        buttonStyle: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.only(
                                                top: 7.adaptSize),
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            alignment: Alignment.center),
                                        buttonTextStyle: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.fSize,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600),
                                        onTap: () async {
                                          // Navigator.pop(context);
                                          final pickedImage =
                                              await ImagePicker().pickImage(
                                                  source: ImageSource.camera);
                                          setState(() {
                                            if (pickedImage != null) {
                                              final selectedImage =
                                                  File(pickedImage.path);
                                              // selectedImages.value
                                              //     .add(selectedImage);
                                              allImages.add(selectedImage);
                                            } else {
                                              print('No image selected.');
                                            }
                                          });
                                        },
                                      )
                                          .animate()
                                          .fade()
                                          .slideY(curve: Curves.easeIn),
                                      const SizedBox(height: 20),
                                      // selectedImages.isNotEmpty ? Text("Okeee"): const Text("Chưa có ảnh"),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(children: [
                                            if (allImages.isNotEmpty)
                                              Obx(() {
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: allImages.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var item = allImages[index];
                                                    if (item is File) {
                                                      return Stack(
                                                        children: [
                                                          CustomImageView(
                                                            file: item,
                                                            width: 0.6 *
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Positioned(
                                                            top: 6,
                                                            right: 6,
                                                            child: CancelButton(
                                                              onPressed: () {
                                                                // ignore: invalid_use_of_protected_member
                                                                allImages.value
                                                                    .remove(
                                                                        item);
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    } else if (item
                                                        is PostDocument) {
                                                      return Stack(
                                                        children: [
                                                          CustomImageView(
                                                            url: item.fileUrl,
                                                            width: 0.6 *
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Positioned(
                                                            top: 6,
                                                            right: 6,
                                                            child: CancelButton(
                                                              onPressed: () {
                                                                // ignore: invalid_use_of_protected_member
                                                                allImages.value
                                                                    .remove(
                                                                        item);
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                    return SizedBox.shrink();
                                                  },
                                                );
                                              }),
                                            if (allImages.isEmpty)
                                              Container(
                                                child: Center(
                                                  child: CustomImageView(
                                                    imagePath: ImageConstant
                                                        .imageNotFound,
                                                    width: 120,
                                                    height: 120,
                                                  ),
                                                ),
                                              ),
                                          ]),
                                        ),
                                      ),
                                      CustomElevatedButton(
                                        text: "Chọn".tr,
                                        onTap: () {
                                          // ignore: invalid_use_of_protected_member
                                          print(allImages.value.length);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ]),
                                  );
                                });
                          }),
                    ),
                  ],
                )),
            SizedBox(height: 10.v),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 1.v),
              decoration: AppDecoration.fillGray200
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListTile(
                        leading: CustomImageView(
                          imagePath: ImageConstant.imgIconlink,
                          height: 20.adaptSize,
                          width: 20.adaptSize,
                        ),
                        title: Text(
                          "lbl_li_n_k_t".tr,
                          style: CustomTextStyles
                              .titleMediumHelveticaOnPrimaryContainer,
                        ),
                        horizontalTitleGap: 0,
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                                            displayTextController.text;
                                        String link = linkController.text;
                                        displayTextController.text = '';
                                        linkController.text = '';
                                        anchorTag =
                                            '<a href="$link">$displayText</a>';
                                        contentTextController.text =
                                            contentTextController.text +
                                                '\n' +
                                                displayText;
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
          ])),
    ));
  }
}

void setState(Null Function() param0) {}

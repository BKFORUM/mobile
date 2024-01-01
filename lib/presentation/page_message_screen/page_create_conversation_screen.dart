import 'dart:io';

import 'package:bkforum/controller/page_messsage_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/choose_user_widget.dart';
import 'package:bkforum/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class PageCreateConversationScreen extends GetWidget<PageMessageController> {
  List<String> userIDs = <String>[];
  TextEditingController textFieldController = TextEditingController();

  void addUserToList(String userID) {
    userIDs.add(userID);
  }

  void deleteUserFromList(String userID) {
    userIDs.remove(userID);
  }

  void acctionClickAddConversation() async {
    if (textFieldController.text.isNotEmpty) {
      controller.addConversation(
        textFieldController.text,
        this.imageUrl.value,
        userIDs,
      );
      userIDs.clear();
      Get.toNamed(
        AppRoutes.pageMessageScreen,
      );
    }
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff0001cb),
      title: Container(
        padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: 180.adaptSize,
            padding: EdgeInsets.only(top: 0, bottom: 5, left: 10, right: 0),
            child: Text(
              "Tạo nhóm chat",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 2,
                color: Color(0xffffffff),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 0, bottom: 0, left: 35, right: 0),
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: Text(
                  "Thêm",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1,
                    color: Color(0xffffffff),
                  ),
                ),
                onPressed: () {
                  acctionClickAddConversation();
                },
              ))
        ]),
      ),
    );
  }

  Rx<String> imageUrl = Rx<String>('DEFAULT_URL_AVATAR_CONVERSATION');
  @override
  Widget build(BuildContext context) {
    controller.geAllUser();
    return SafeArea(
      child: Scaffold(
          appBar: buildAppBar(),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: textFieldController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nhập tên nhóm',
                    ),
                  ),
                ),
                Container(
                  height: 70.adaptSize,
                  width: 70.adaptSize,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          BorderRadius.all(Radius.circular(20.adaptSize))),
                  child: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            clipBehavior: Clip.hardEdge,
                            padding: EdgeInsets.fromLTRB(10.adaptSize,
                                26.adaptSize, 10.adaptSize, 10.adaptSize),
                            height: 110.adaptSize,
                            child: Column(
                              children: [
                                CustomElevatedButton(
                                  text: "Chọn từ thư viện".tr,
                                  buttonStyle: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.only(top: 7.adaptSize),
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
                                      source: ImageSource.gallery,
                                    );
                                    if (pickedImage != null) {
                                      this.imageUrl.value = (await controller
                                          .getImageUrl(File(pickedImage.path)));
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white);
                    },
                    child: Obx(() {
                      return CustomImageView(
                        url: this.imageUrl.toString(),
                        fit: BoxFit.cover,
                      );
                    }),
                  ),
                ),
                Expanded(
                    child: (Obx(() {
                  return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 5.v);
                      },
                      itemCount: controller.users.length,
                      itemBuilder: (context, index) {
                        return ChooseUserWidget(
                          user: controller.users[index],
                          callbackAdd: (content) => addUserToList(content),
                          callbackDelete: (content) =>
                              deleteUserFromList(content),
                        );
                      });
                }))),
              ],
            ),
          )),
    );
  }
}

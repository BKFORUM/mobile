import 'package:bkforum/controller/page_messsage_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/choose_user_widget.dart';
import 'package:flutter/material.dart';

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
        "https://res.cloudinary.com/dy7he6gby/image/upload/v1703826093/wheoqyp7iw6nlzsnc7gj.png",
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

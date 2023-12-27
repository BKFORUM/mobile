import 'package:bkforum/controller/page_message_detail_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/choose_user_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageAddUserToConversation extends GetWidget<PageMessageDetailController> {
  List<String> userIDs = <String>[];
  void addUserToList(String userID) {
    userIDs.add(userID);
  }

  void deleteUserFromList(String userID) {
    userIDs.remove(userID);
  }

  addUsers() async {
    await controller.addUsersToConversation(userIDs);
    await controller.getUsersOutsideOfForum();
    userIDs.clear();
  }

  @override
  Widget build(BuildContext context) {
    controller.getUsersOutsideOfForum();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thêm thành viên",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => {
                      if(userIDs.isNotEmpty){
                        addUsers(),
                      }
                    },
                    child: Text(
                      'Thêm',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        height: 1.2175,
                        color: Color.fromARGB(255, 232, 219, 219),
                      ),
                    ),
                  )
                ],
              )),
          body: SizedBox(
              width: double.maxFinite,
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: AppDecoration.fillOnErrorContainer,
                        child: Center(
                          child: ListView(
                            children: [
                              (Obx(() {
                                return ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 5.v);
                                    },
                                    itemCount: controller
                                        .listUserOutsideOfForum.length,
                                    itemBuilder: (context, index) {
                                      return ChooseUserWidget(
                                        user: controller
                                            .listUserOutsideOfForum[index],
                                        callbackAdd: (content) =>
                                            addUserToList(content),
                                        callbackDelete: (content) =>
                                            deleteUserFromList(content),
                                      );
                                    });
                              }))
                            ],
                          ),
                        )))
              ]))),
    );
  }
}

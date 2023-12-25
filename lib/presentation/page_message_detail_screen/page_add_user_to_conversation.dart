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

  void deleteUserFromList(String userID){
    userIDs.remove(userID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Thành viên",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          body: SizedBox(
              width: double.maxFinite,
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: AppDecoration.fillOnErrorContainer,
                        child: Center(
                          child: ListView(
                            children: [
                              (Obx((){
                                controller.getUsersOutsideOfForum();
                                return ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 5.v);
                                  },
                                  itemCount: controller.listUserOutsideOfForum.length,
                                  itemBuilder: (context, index) {
                                    return ChooseUserWidget(
                                      user: controller.listUserOutsideOfForum[index], 
                                      callbackAdd: (content) => addUserToList(content), 
                                      callbackDelete: (content) => deleteUserFromList(content),
                                    );
                                  });}))
                            ],
                          ),
                        )))
              ]))),
    );
  }
}

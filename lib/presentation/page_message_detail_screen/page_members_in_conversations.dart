import 'package:bkforum/controller/page_message_detail_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/member_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageMemberInConversation extends GetWidget<PageMessageDetailController> {
  @override
  Widget build(BuildContext context) {
    controller.getUsersInConversation();
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
                              (Obx(() => ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 5.v);
                                  },
                                  itemCount: controller.listUser.length,
                                  itemBuilder: (context, index) {
                                    UserConversation user =
                                        controller.listUser[index];
                                    return MemberWidget(
                                      user: user,
                                      callback: (content, id) =>
                                          clickButtonChangeDisplayName(
                                              content, id),
                                    );
                                  })))
                            ],
                          ),
                        )))
              ]))),
    );
  }

  void clickButtonChangeDisplayName(String content, String userID) {
    controller.changeDisplayName(content, userID);
  }
}

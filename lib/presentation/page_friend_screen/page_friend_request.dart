import 'package:bkforum/controller/page_friend_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_friend_screen/widget/friend_request_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageFriendRequest extends GetWidget<PageFriendController>{
   PageFriendRequest({Key? key}): super(key: key);
  
    @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Lời mời kết bạn",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.h),
                          padding: EdgeInsets.symmetric(vertical: 6.v),
                          decoration: AppDecoration.fillOnErrorContainer,
                          child:(Obx(() => ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 10.v);
                              },
                              itemCount: controller.friendRequests.length,
                              itemBuilder: (context, index) {
                                return FriendRequestWidget(controller.friendRequests[index]);
                              })))))
                ]))
        )
      );
     }
  
}
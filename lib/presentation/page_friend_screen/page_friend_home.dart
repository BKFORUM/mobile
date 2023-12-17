import 'package:bkforum/controller/page_friend_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_friend_screen/widget/friend_request_widget.dart';
import 'package:bkforum/presentation/page_friend_screen/widget/friend_suggest_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageFriendsScreen extends GetWidget<PageFriendController> {
  PageFriendsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Bạn bè",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Container(
                    // frame194DuM (13:232)
                    padding: EdgeInsets.fromLTRB(
                        9.adaptSize, 6.adaptSize, 85.adaptSize, 6.adaptSize),
                    width: double.infinity,
                    height: 39.adaptSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0x33000000)),
                      color: Color(0xffffffff),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // commentbuttonb9D (13:235)
                          width: 82.adaptSize,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffb0b0b0),
                            borderRadius: BorderRadius.circular(15.adaptSize),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              clickButtonFriendRequest();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffb0b0b0)),
                            child: Text(
                              'Lời mời',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                height: 1.2125,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.adaptSize,
                        ),
                        Container(
                          // commentbuttonb9D (13:235)
                          width: 82.adaptSize,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffb0b0b0),
                            borderRadius: BorderRadius.circular(15.adaptSize),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              clickButtonFriendSuggest();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffb0b0b0)),
                            child: Text(
                              'Đề xuất',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                height: 1.2125,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.adaptSize,
                        ),
                        Container(
                          // commentbuttonedH (13:237)
                          width: 82.adaptSize,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffb0b0b0),
                            borderRadius: BorderRadius.circular(15.adaptSize),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              clickButtonMyFriend();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffb0b0b0)),
                            child: Text(
                              'Bạn bè',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                height: 1.2125,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          decoration: AppDecoration.fillOnErrorContainer,
                          child: Center(
                              child: ListView(
                            children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(9.5.adaptSize,
                                      10.adaptSize, 5.adaptSize, 9.5.adaptSize),
                                  child: Text(
                                    'Lời mời kết bạn',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2175,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Obx(() => ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 10.v);
                                    },
                                    itemCount: controller.friendRequests.length,
                                    itemBuilder: (context, index) {
                                      return FriendRequestWidget(
                                          controller.friendRequests[index]);
                                    })),
                                Container(
                                  // group35Ehy (16:355)
                                  margin: EdgeInsets.fromLTRB(30.adaptSize,
                                      0.adaptSize, 30.adaptSize, 0.adaptSize),
                                  width: double.infinity,
                                  height: 30.adaptSize,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(10.adaptSize),
                                  ),
                                  child: Container(
                                    // frame162xP5 (16:356)
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xff0001cb),
                                      borderRadius:
                                          BorderRadius.circular(10.adaptSize),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        clickButtonFriendRequest();
                                      },
                                      child: Text(
                                        'Xem tất cả',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          height: 1.2125,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                // limiktbnPUX (21:72)
                                margin: EdgeInsets.fromLTRB(9.5.adaptSize,
                                    10.adaptSize, 5.adaptSize, 9.5.adaptSize),
                                child: Text(
                                  'Người bạn có thể biết',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Obx(() => ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10.v);
                                  },
                                  itemCount: controller.friendSuggest.length,
                                  itemBuilder: (context, index) {
                                    return FriendSuggestWidget(
                                        controller.friendSuggest[index]);
                                  })),
                              Container(
                                // group35Ehy (16:355)
                                margin: EdgeInsets.fromLTRB(30.adaptSize,
                                    0.adaptSize, 30.adaptSize, 0.adaptSize),
                                width: double.infinity,
                                height: 30.adaptSize,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(10.adaptSize),
                                ),
                                child: Container(
                                  // frame162xP5 (16:356)
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0001cb),
                                    borderRadius:
                                        BorderRadius.circular(10.adaptSize),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      clickButtonFriendSuggest();
                                    },
                                    child: Text(
                                      'Xem tất cả',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2125,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ))))
                ]))));
  }
  void clickButtonFriendRequest() {
    Get.toNamed(
      AppRoutes.pageFriendRequestScreen,
    );
  }

  void clickButtonFriendSuggest() {
    Get.toNamed(
      AppRoutes.pageFriendSuggestScreen,
    );
  }

  void clickButtonMyFriend() {
    Get.toNamed(
      AppRoutes.pageMyFriendScreen,
    );
  }
}



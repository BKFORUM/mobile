import 'package:bkforum/controller/page_message_detail_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PageMessageSettingScreen extends GetWidget<PageMessageDetailController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Thông tin",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 100.adaptSize,
                  height: 100.adaptSize,
                  child: CachedNetworkImage(
                    imageUrl: controller.conversation.avatarUrl.toString(),
                    imageBuilder: ((context, imageProvider) => Container(
                          height: 100.adaptSize,
                          width: 100.adaptSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(45.adaptSize)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        )),
                    errorWidget: (context, url, error) => Image(
                      image: AssetImage(DEFAULT_URL_AVATAR_CONVERSATION),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Align(
                child: SizedBox(
                  width: 250.adaptSize,
                  height: 31.adaptSize,
                  child: Text(
                    controller.conversation.displayName.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.2575,
                      letterSpacing: 0.3300000131.adaptSize,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                // rowsqgd (0:13988)
                margin: EdgeInsets.fromLTRB(0.adaptSize, 0, 0, 26),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {clickSeeMembers()},
                        child: Container(
                          padding: EdgeInsets.fromLTRB(16.adaptSize,
                              14.adaptSize, 16.adaptSize, 14.adaptSize),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Xem thành viên',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575,
                                    letterSpacing: -0.4099999964.adaptSize,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Container(
                                // ovalPbf (0:13993)
                                width: 24.adaptSize,
                                height: 24.adaptSize,
                                child: Image.asset(
                                  ImageConstant.iconGroupChat,
                                  width: 24.adaptSize,
                                  height: 24.adaptSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () => {
                            clickAddUserToConversation()
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16.adaptSize,
                                14.adaptSize, 16.adaptSize, 14.adaptSize),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => {},
                                  child: Text(
                                    'Thêm thành viên',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2575,
                                      letterSpacing: -0.4099999964.adaptSize,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Container(
                                  // ovalPbf (0:13993)
                                  width: 24.adaptSize,
                                  height: 24.adaptSize,
                                  child: Image.asset(
                                    ImageConstant.iconAddUsertToConversation,
                                    width: 24.adaptSize,
                                    height: 24.adaptSize,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.adaptSize, 14.adaptSize,
                            16.adaptSize, 14.adaptSize),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // colortQ1 (0:13991)
                              // margin: EdgeInsets.fromLTRB(0.adaptSize,
                              //     2.adaptSize, 282.adaptSize, 0.adaptSize),
                              child: Text(
                                'Rời khỏi nhóm',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2575,
                                  letterSpacing: -0.4099999964.adaptSize,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Container(
                              // ovalPbf (0:13993)
                              width: 24.adaptSize,
                              height: 24.adaptSize,
                              child: Image.asset(
                                ImageConstant.iconOutConversation,
                                width: 24.adaptSize,
                                height: 24.adaptSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    ));
  }

  clickSeeMembers() {
    Get.toNamed(AppRoutes.pageMembersInConversation,
        arguments: controller.conversation);
  }
  clickAddUserToConversation() {
    Get.toNamed(AppRoutes.pageAddUserToConversation,
        arguments: controller.conversation);
  }
}

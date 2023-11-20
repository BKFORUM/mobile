import 'package:bkforum/presentation/page_feed_screen/widgets/custom_comment_screen.dart';
import 'package:bkforum/presentation/page_notification_screen/page_notification_screen.dart';
import 'package:bkforum/widgets/image_slider.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_reaction.dart';
import '../controller/page_feed_controller.dart';
import '../models/userpost_item_model.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class UserpostItemWidget extends StatelessWidget {
  UserpostItemWidget(
    this.userpostItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  UserpostItemModel userpostItemModelObj;

  var controller = Get.find<PageFeedController>();
  final PageFeedController comments_controller = Get.put(PageFeedController());
  bool isOverflowVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.v),
      decoration: AppDecoration.outlineGray,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.fromLTRB(10.adaptSize, 26.adaptSize, 10.adaptSize, 10.adaptSize),
                        height: 700.adaptSize,
                        child: Column(
                          children: [
                          ],
                        ),
                      ),
                      isScrollControlled: true,
                      // ignoreSafeArea: true,
                    );
                  // loadPost();
                  },
                child: Container(
                    padding: EdgeInsets.all(8.h),
                    decoration: AppDecoration.fillOnErrorContainer,
                    child: Row(
                      children: [
                        CustomImageView(
                          url: userpostItemModelObj.userAvatar!.value,
                          fit: BoxFit.cover,
                          height: 20.adaptSize,
                          width: 20.adaptSize,
                          radius: BorderRadius.circular(
                            10.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 4.h,
                            top: 2.v,
                          ),
                          child: Text(
                            userpostItemModelObj.userCreate!.value,
                            style: CustomTextStyles.titleSmallRobotoBlack900,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 3.v),
                          child:
                            Obx(
                              () => Text(
                                userpostItemModelObj.forumName!.value,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
              ),
              GestureDetector(
                onTap: (){},
                child: Container(
                  width: 354.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.h,
                    vertical: 2.v,
                  ),
                  decoration: AppDecoration.fillOnErrorContainer,
                  
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.h),
                      child: Html(
                          data: userpostItemModelObj.postContent!.value,
                        ),
                    ),
                ),
              ),

              ImageSlider(userpostItemModelObj.listImages!.value),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 2.v,
                  width: 9.h,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 14.h,
                  top: 13.v,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomReaction(),
                        Padding(
                          padding: EdgeInsets.only(left: 6.h),
                          child: Text(
                            "yêu thích",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                                CustomCommentScreen(
                                    userpostItemModelObj.id!.value),
                                isScrollControlled: true,
                                ignoreSafeArea: false,
                                enableDrag: true
                            );},
                          child: Row(
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgComment,
                                height: 16.adaptSize,
                                width: 16.adaptSize,
                                margin: EdgeInsets.only(left: 13.h),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6.h),
                                child: Text(
                                  "bình luận",
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    IconButton(
                        onPressed: (){
                          Get.bottomSheet(
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.fromLTRB(10.adaptSize, 26.adaptSize, 10.adaptSize, 10.adaptSize),
                                  // height: 1.adaptSize,
                                  child:  Flex(
                                      direction: Axis.vertical,
                                      children: [
                                        Padding(padding: EdgeInsets.only(left: 20.h, top: 20.v),child: Row(children: [
                                          IconButton(
                                              onPressed: (){

                                              },
                                              icon: Icon(Icons.edit)),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.h, top: 2.adaptSize, bottom: 2.adaptSize),
                                              child: Text("Chỉnh sửa",
                                                  style: CustomTextStyles.bodyLargeInter)),
                                        ])),
                                        Padding(padding: EdgeInsets.only(left: 20.h, top: 20.v),child: Row(children: [
                                          IconButton(
                                              onPressed: (){

                                              },
                                              icon: Icon(Icons.cancel_rounded)),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.h, top: 2.adaptSize, bottom: 2.adaptSize),
                                              child: Text("Xóa",
                                                  style: CustomTextStyles.bodyLargeInter)),
                                        ])),
                                      ])
                              )
                          );
                        },
                        icon: Icon(Icons.more_vert))
                  ],
                ),
              ),
            ],
          ),
      );
  }
}
class ContentOverflowController extends GetxController {
  var isOverflowVisible = false.obs;

  void toggleOverflow() {
    isOverflowVisible.value = !isOverflowVisible.value;
    if (isOverflowVisible.value) {
      Get.snackbar('Overflow is visible! + $isOverflowVisible', '', duration: Duration(seconds: 2));
    }
  }
}
Widget buildImage(String urlImage, int index) => Container(
  margin: EdgeInsets.symmetric(horizontal: 1.adaptSize),
  child: Image.network(
    urlImage,
    fit: BoxFit.cover,
  ),
);


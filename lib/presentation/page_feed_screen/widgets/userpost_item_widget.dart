import 'package:bkforum/presentation/page_feed_screen/widgets/custom_comment_screen.dart';
import 'package:bkforum/presentation/page_notification_screen/page_notification_screen.dart';

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
                      )
                    );
                  },
                child: Container(
                    padding: EdgeInsets.all(8.h),
                    decoration: AppDecoration.fillOnErrorContainer,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgIconavatar,
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
                            "msg_nguy_n_nh_t_h_ng".tr,
                            style: CustomTextStyles.titleSmallRobotoBlack900,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 3.v),
                          child:
                            Obx(
                              () => Text(
                                userpostItemModelObj.lpsinhhot20tclc!.value,
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
                onTap: (){
                  Get.showSnackbar(GetSnackBar(
                    message: 'Overflow is visible!',
                    duration: Duration(seconds: 1),
                  ));
                  isOverflowVisible = !isOverflowVisible;
                },
                child: Container(
                  width: 354.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.h,
                    vertical: 2.v,
                  ),
                  decoration: AppDecoration.fillOnErrorContainer,
                  
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.h),
                      child:
                          Obx(
                            () => Text(
                              userpostItemModelObj.postContent!.value,
                              overflow: isOverflowVisible ? TextOverflow.visible : TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge,
                              maxLines: 3,
                            ),
                          ),
                    ),
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgImage,
                height: 265.v,
                width: 354.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 2.v,
                  width: 9.h,
                  decoration: BoxDecoration(
                    color: appTheme.blueGray100,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 14.h,
                  top: 13.v,
                ),
                child: Row(
                  children: [
                    CustomReaction(),
                    Padding(
                      padding: EdgeInsets.only(left: 6.h),
                      child: Text(
                        "lbl_40_y_u_th_ch".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {Get.bottomSheet(CustomCommentScreen());},
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
                              "lbl_15_b_nh_lu_n".tr,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7.v),
              GestureDetector(
                onTap:( ){
                  Get.bottomSheet(
                    CustomCommentScreen()
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 7.v,
                  ),
                  decoration: AppDecoration.fillOnErrorContainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 7.v),
                      Text(
                        "lbl_xem_b_nh_lu_n".tr,
                        style: CustomTextStyles.bodyMediumGray500,
                      ),
                    ],
                  ),
                ),
              )
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
      Get.snackbar('Overflow is visible!', '', duration: Duration(seconds: 2));
    }
  }
}
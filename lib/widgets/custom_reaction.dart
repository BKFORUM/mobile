import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/userpost_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../controller/page_feed_controller.dart';
import '../core/utils/image_constant.dart';
import 'custom_image_view.dart';

class CustomReaction extends StatelessWidget {
  final UserpostItemModel userpostItemModelObj;
  final RxBool isCustomImageReacted;
  final PageFeedController controller = Get.put(PageFeedController());

  CustomReaction(
    this.userpostItemModelObj, {
    Key? key,
  })  : isCustomImageReacted =
            (userpostItemModelObj.likedAt != DateTime(2012, 1, 1)).obs,
        super(key: key);

  void toggleCustomImage() {
    isCustomImageReacted.value = !isCustomImageReacted.value;
    controller.changeReaction(userpostItemModelObj);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCustomImage,
      child: Obx(() {
        return isCustomImageReacted.value
            ? CustomImageView(
                svgPath: ImageConstant.imgReact,
                height: 16.v,
                width: 16.h,
                margin: EdgeInsets.only(bottom: 2.v),
              )
                .animate()
                .shake()
                .tint(color: Colors.red, duration: 50.ms, delay: 50.ms)
                .scaleXY(begin: 1.4, end: 1)
            : CustomImageView(
                svgPath: ImageConstant.imgNonReact,
                height: 16.v,
                width: 16.h,
                margin: EdgeInsets.only(bottom: 2.v),
              );
      }),
    );
  }
}

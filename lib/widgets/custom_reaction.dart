import 'package:bkforum/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/utils/image_constant.dart';
import 'custom_image_view.dart';

class CustomReaction extends StatefulWidget {
  @override
  _CustomReactionState createState() => _CustomReactionState();
}

class _CustomReactionState extends State<CustomReaction> {
  bool isCustomImageReacted = false;

  void toggleCustomImage() {
    setState(() {
      isCustomImageReacted = !isCustomImageReacted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: toggleCustomImage,
        child: isCustomImageReacted ? CustomImageView(
          svgPath: ImageConstant.imgLocation,
          height: 12.v,
          width: 14.h,
          margin: EdgeInsets.only(bottom: 2.v),
        ).animate().tint(color: Colors.red).shakeX()
            : CustomImageView(
                  svgPath: ImageConstant.imgLocation,
                  height: 12.v,
                  width: 14.h,
                  margin: EdgeInsets.only(bottom: 2.v),
            ), // Hiển thị một SizedBox nếu không muốn hiển thị CustomImageView
      );
  }
}
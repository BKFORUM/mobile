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
          svgPath: ImageConstant.imgReact,
          height: 16.v,
          width: 16.h,
          margin: EdgeInsets.only(bottom: 2.v),
        ).animate().shake().tint(color: Colors.red, duration: 50.ms, delay: 50.ms)
        .scaleXY(begin: 1.4, end: 1 )
            : CustomImageView(
                  svgPath: ImageConstant.imgNonReact,
                  height: 16.v,
                  width: 16.h,
                  margin: EdgeInsets.only(bottom: 2.v),
            ),
    );
  }
}
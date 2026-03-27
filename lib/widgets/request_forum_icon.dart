import 'package:bkforum/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../controller/page_forumone_controller.dart';
import '../data/models/data_prop/forum.dart';

class RequestForumIcon extends StatelessWidget{
  late final Forum forum;
  final RxBool isRequested;
  final PageForumoneController controller = Get.put(PageForumoneController());
  RequestForumIcon(
    this.forum, {
    Key? key,
  })  : isRequested = (forum.yourStatus == 'PENDING').obs, super(key: key);

  void toggleCustomImage() {
    controller.changeRequestStatus(forum);
    (forum.yourStatus == "PENDING") ? forum.yourStatus = "NOT_MEMBER"
    : forum.yourStatus = "PENDING";
    isRequested.value = !isRequested.value;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCustomImage,
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 0, 2),
          child: isRequested.value
              ? Icon(Icons.group_add_rounded, size: 24.adaptSize)
              .animate()
              .shake()
              .tint(color: Colors.amber, duration: 50.ms, delay: 50.ms)
              .scaleXY(begin: 1.4, end: 1)
              : Icon(Icons.group_add_rounded, size: 24.adaptSize),
        );
      }),
    );
  }
}
import 'package:bkforum/controller/event_controller.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:flutter/material.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomParticipate extends StatelessWidget{
  final Event event;
  final Rx<bool> isCustomIconReacted;
  final EventController controller = Get.put(EventController());
  
  CustomParticipate(
      this.event, {
        Key? key,
      })  : isCustomIconReacted = event.isSubscriber ?? Rx(false),
        super(key: key);

  Future<void> toggleCustomImage() async {
    if (event.status?.value == 'HAPPENING' || event.status?.value == 'UPCOMING') {
      isCustomIconReacted.value = !isCustomIconReacted.value;
      controller.changeParticipate(event);
      // isCustomIconReacted.value ? event.count?.value.users = event.count!.value.users!+1 : event.count?.value.users = event.count!.value.users!-1;
    } else {
      Get.snackbar('Sự kiện đã kết thúc', 'Không thể tham gia hoặc hủy tham gia',
          backgroundColor: Colors.amber
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCustomImage,
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 0, 2),
          child: isCustomIconReacted.value
              ? Icon(Icons.star_rate_rounded, size: 24.adaptSize)
              .animate()
              .shake()
              .tint(color: Colors.amber, duration: 50.ms, delay: 50.ms)
              .scaleXY(begin: 1.4, end: 1)
              : Icon(Icons.star_border_rounded, size: 24.adaptSize),
        );
      }),
    );
  }
  
}
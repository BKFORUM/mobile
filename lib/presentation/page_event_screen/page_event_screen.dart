import 'package:bkforum/controller/event_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:bkforum/widgets/event_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:bkforum/widgets/progress_indicator.dart';

// ignore: must_be_immutable
class PageEventScreen extends GetView<EventController> {
  Rx<List<Event>> listEvent = Rx<List<Event>>([]);

  @override
  Widget build(BuildContext context) {
    controller.fetchEvents();

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              title: Text('Sự kiện'),
            ),
            body: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
              } else if (scrollNotification is ScrollUpdateNotification) {
              } else if (scrollNotification is ScrollEndNotification) {}
              return true;
            }, child: Obx(() {
              controller.fetchEvents().then((value) {
                listEvent.value = value;
              });
              if(listEvent.value.isEmpty){
                return CustomProgressIndicator();
              } else{
                return RefreshIndicator(
                  onRefresh: () async {
                    listEvent.value.clear();
                  },
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 10.v,
                        color: Colors.black12,
                      );
                    },
                    itemCount: listEvent.value.length,
                    itemBuilder: (context, index) {
                      Event model = listEvent
                      // ignore: invalid_use_of_protected_member
                          .value[index];
                      return EventItemWidget(model);
                    },
                  ),
                );
              }

            }))));
  }
}

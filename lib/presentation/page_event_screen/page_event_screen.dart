import 'package:bkforum/controller/event_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:bkforum/widgets/event_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bkforum/widgets/progress_indicator.dart';

class PageEventScreen extends GetView<EventController> {
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
                },
                child: Obx(() => RefreshIndicator(
                      onRefresh: () async => controller.refreshEventData(),
                      child: controller.eventsList
                              .value.isEmpty
                          ? Center(
                              child: CustomProgressIndicator(),
                            )
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 10.v,
                                  color: Colors.black12,
                                );
                              },
                              itemCount: controller.eventsList.value.length.obs.value,
                              itemBuilder: (context, index) {
                                Event model = controller
                                    .eventsList
                                    .value[index];
                                return EventItemWidget(model);
                              },
                            ),
                    )))));
  }
}

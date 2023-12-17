import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import 'custom_comment_screen.dart';
import 'custom_reaction.dart';
import 'image_slider.dart';

class EventItemWidget extends StatelessWidget {
  EventItemWidget(
    this.eventItemModelObj, {
    Key? key,
  }) : super(key: key);

  Event eventItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.adaptSize),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Row(
              children: [
                SizedBox(width: 6.adaptSize),
                Icon(Icons.access_alarms_rounded,
                    size: 16.adaptSize, color: Colors.red),
                SizedBox(width: 6.adaptSize),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm')
                      .format(eventItemModelObj.startAt!.value),
                  style: TextStyle(
                    fontSize: 16.adaptSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 6.adaptSize),
                Icon(Icons.arrow_right_rounded,
                    size: 16.adaptSize, color: Colors.red),
                SizedBox(width: 6.adaptSize),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm')
                      .format(eventItemModelObj.endAt!.value),
                  style: TextStyle(
                    fontSize: 16.adaptSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 10.adaptSize),
              padding: EdgeInsets.all(10.adaptSize),
              decoration: BoxDecoration(
                  color: (eventItemModelObj.status?.value=='DONE' ? Colors.grey.shade500 : Colors.green.shade400),
                  borderRadius: BorderRadius.all(Radius.circular(10.adaptSize))),
              child: Text(
                eventItemModelObj.status!.value,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
              ),
            )
          ]),
          SizedBox(height: 12.adaptSize),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.adaptSize),
            child: Text(
              eventItemModelObj.displayName!.value,
              style: TextStyle(
                  fontSize: 18.adaptSize, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.adaptSize),
            child: Text(
              eventItemModelObj.location!.value,
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade600),
            ),
          ),
          Html(
            data: eventItemModelObj.content!.value,
          ),
          ImageSlider(eventItemModelObj.documents?.value
              .map((document) => document.fileUrl!)
              .toList()),
          SizedBox(height: 12.adaptSize),
          Row(
            children: [
              // CustomReaction(eventItemModelObj),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "${eventItemModelObj.count?.value.users} tham gia",
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                      CustomCommentScreen(
                          eventItemModelObj.id!.value, 'events'),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                      enableDrag: true);
                },
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
                        "${eventItemModelObj.count?.value.comments} bình luận",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6.adaptSize),
        ],
      ),
    );
  }
}
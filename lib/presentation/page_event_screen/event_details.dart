import 'package:bkforum/controller/event_controller.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:bkforum/widgets/event_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:bkforum/core/app_export.dart';
import '../../core/utils/size_utils.dart';
import '../../widgets/progress_indicator.dart';

class EventDetail extends StatelessWidget{
  EventDetail({
    Key? key,
  }) : super(key: key);
  final EventController controller = Get.put(EventController());
  final eventId = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () => Get.back(),
                ),
                title: Text("Chi tiết sự kiện sắp diễn ra")
            ),
            body:
            Container(
                child: FutureBuilder<Event>(
                    future: controller.getEventById(eventId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final eventObj = snapshot.data;
                        return Column(
                            children: [
                              EventItemWidget(eventObj!),
                              // Expanded(child: CustomCommentScreen(userPostObj.id!.value, 'posts')),
                            ]);
                      }
                    }
                ))));
  }

}
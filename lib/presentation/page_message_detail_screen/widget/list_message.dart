import 'package:flutter/material.dart';


class ListMessage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

// class ListMessageState extends State<ListMessage> {
//   String id;
//   ListMessageState({required this.id})

//   PageMessageDetailController controller = Get.put(PageMessageDetailController(id: '')));
//   @override
//   Widget build(BuildContext context) {
//     return (Obx(() => ListView.separated(
//                     reverse: true,
//                       physics: BouncingScrollPhysics(),
//                       shrinkWrap: true,
//                       separatorBuilder: (context, index) {
//                         return SizedBox(height: 5.v);
//                       },
//                       itemCount: controller.messages.length,
//                       itemBuilder: (context, index) {
//                         if (index % 2 == 0) {
//                           return ChatLeftItem(controller.messages[index]);
//                         }
//                         return ChatRightItem(controller.messages[index]);
//                       })));
//   }

// }
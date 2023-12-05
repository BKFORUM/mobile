import 'package:bkforum/controller/page_message_detail_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/chat_left_item.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/chat_right_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageMessageDetailScreen extends GetWidget<PageMessageDetailController> {
  PageMessageDetailScreen({Key? key}) : super(key: key);

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff0001cb),
      title: Container(
        padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
        child: Row(children: [
          SizedBox(
            width: 45.adaptSize,
            height: 45.adaptSize,
            child: CachedNetworkImage(
              imageUrl:
                  'https://scontent.fsgn2-11.fna.fbcdn.net/v/t39.30808-6/408266063_673683761583264_183572100328065104_n.jpg?stp=cp6_dst-jpg&_nc_cat=105&ccb=1-7&_nc_sid=dd5e9f&_nc_ohc=z6PbIrWjXFgAX-mXXWi&_nc_ht=scontent.fsgn2-11.fna&oh=00_AfB_sF8Tyt7trCzLTg6sUxB6uPH2OHQN_9a6Ef8DsdW3Dg&oe=65738968',
              imageBuilder: ((context, imageProvider) => Container(
                    height: 45.adaptSize,
                    width: 45.adaptSize,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(45.adaptSize)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  )),
              errorWidget: (context, url, error) => Image(
                image: AssetImage(DEFAULT_URL_AVATAR_CONVERSATION),
              ),
            ),
          ),
          Container(
            width: 180.adaptSize,
            padding: EdgeInsets.only(top: 0, bottom: 5, left: 10, right: 0),
            child: Text(
              'Trương Quang Khang',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 2,
                color: Color(0xffffffff),
              ),
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0.h,
                    height: 50.h,
                    child: Container(
                      //padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      width: double.maxFinite,
                      height: 50.adaptSize,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 15.adaptSize, top: 5.adaptSize),
                            width: 300.adaptSize,
                            height: 50.adaptSize,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Colors.black, // Set the border color here
                                width: 0.2, // Set the border width here
                              ),
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the border radius here
                            ),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              autofocus: false,
                              decoration:
                                  InputDecoration(hintText: "Send messages..."),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 15.adaptSize, top: 5.adaptSize),
                            width: 65.adaptSize,
                            height: 35.adaptSize,
                            child: ElevatedButton(
                              child: Text(
                                "Send",
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  (Obx(() => ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 5.v);
                      },
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          return ChatLeftItem(controller.messages[index]);
                        }
                        return ChatRightItem(controller.messages[index]);
                      })))
                ],
              ),
            )));
  }
}

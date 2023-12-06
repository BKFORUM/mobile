import 'package:bkforum/controller/page_message_detail_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/chat_left_item.dart';
import 'package:bkforum/presentation/page_message_detail_screen/widget/chat_right_item.dart';
import 'package:bkforum/widgets/custom_text_form_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageMessageDetailScreen extends GetWidget<PageMessageDetailController> {
  PageMessageDetailScreen({Key? key}) : super(key: key);
  TextEditingController textController = TextEditingController();

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
              child: Column(
                children: [
                  Expanded(
                    child: (Obx(() => ListView.separated(
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 5.v);
                        },
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          if (controller.myId !=
                              controller.messages[index].author?.id) {
                            return ChatLeftItem(controller.messages[index]);
                          }
                          return ChatRightItem(controller.messages[index]);
                        }))),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(children: [
                        
                        SizedBox(width: 20),
                        Expanded(
                            child: CustomTextFormField(
                                controller: textController,
                                hintText: "msg_th_m_b_nh_lu_n".tr,
                                hintStyle: theme.textTheme.titleSmall,
                                textInputAction: TextInputAction.done,
                                borderDecoration: InputBorder.none,
                                // TextFormFieldStyleHelper,
                                filled: false,
                                fillColor: appTheme.blueGray100,
                                suffix: IconButton(
                                  icon: Icon(Icons.send),
                                  iconSize: 16.adaptSize,
                                  onPressed: () {
                                    if (textController.text.isNotEmpty) {
                                      controller
                                          .sendMessage(textController.text);
                                      textController.clear();
                                    }
                                  },
                                ))),
                      ])),
                ],
              ),
            )));
  }
}

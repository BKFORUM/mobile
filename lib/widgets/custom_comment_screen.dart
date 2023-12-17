import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/comments_model.dart';
import 'package:bkforum/presentation/page_notification_screen/page_notification_screen.dart';
import 'package:bkforum/widgets/comment_reply_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/comments_controller.dart';
import 'custom_text_form_field.dart';

// ignore: must_be_immutable
class CustomCommentScreen extends StatelessWidget {
  final String id;
  final String type;
  final CommentController commentController = CommentController();

  CustomCommentScreen(this.id, this.type, {Key? key}) : super(key: key);

  TextEditingController _textEditingController = TextEditingController();

  void handleSendButtonPressed(String comment, bool repMode) {
    commentController.uploadCommentOrReply(id, comment, repMode);
    _textEditingController.text = '';
    commentController.fetchComments(id, type);
  }

  Future<bool> checkEditDeleteComment(CommentsModel comment) async {
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');

    if (userId == comment.userCreate?.value)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    commentController.refresh();
    commentController.replyMode = false;
    return Obx(() {
      commentController.fetchComments(id, type);
      final commentsList = commentController.commentsList;
      if (commentsList.isEmpty) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(10.adaptSize),
            child: Column(children: [
              Expanded(
                child: Center(
                  child: Text(
                      "Ở đây chưa có bình luận nào, hãy là người đầu tiên bình luận."),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(children: [
                    SizedBox(width: 10),
                    Expanded(
                        child: CustomTextFormField(
                            controller: _textEditingController,
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
                                if (_textEditingController.text != '') {
                                  handleSendButtonPressed(
                                      _textEditingController.text, false);
                                }
                              },
                            )))
                  ]))
            ]));
      }

      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(10.adaptSize),
          child: Flex(direction: Axis.vertical, children: [
            Container(
                padding: EdgeInsets.only(top: 20.adaptSize),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                )),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    setState(() {});
                  } else if (scrollNotification is ScrollUpdateNotification) {
                    setState(() {});
                  } else if (scrollNotification is ScrollEndNotification) {
                    commentController.fetchMoreComments(
                        id, type, commentController.commentsList.length);
                  }
                  return true;
                },
                child: ListView.builder(
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    final comment = commentsList[index];
                    final isExpanded = commentController.isExpandedList[index];
                    return Column(children: [
                      GestureDetector(
                        onDoubleTap: () {
                          commentController.changeToReplyMode(comment);
                        },
                        onLongPress: () {
                          // if (checkEditDeleteComment)
                          Get.dialog(Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading:
                                              Icon(Icons.edit_note_rounded),
                                          title: Text('Chỉnh sửa bình luận',
                                              style: TextStyle(fontSize: 16)),
                                          onTap: () => commentController
                                              .updateComment(comment),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.cancel_rounded),
                                          title: Text('Xóa bình luận',
                                              style: TextStyle(fontSize: 16)),
                                          onTap: () => commentController
                                              .deleteComment(comment),
                                        )
                                      ]))));
                        },
                        child: ListTile(
                          leading: Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 8.adaptSize),
                              child: CustomImageView(
                                  url: comment.userAvatar!.value,
                                  fit: BoxFit.cover,
                                  height: 28.adaptSize,
                                  width: 28.adaptSize,
                                  radius: BorderRadius.circular(14.h))),
                          title: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, 0, 4.adaptSize, 6.adaptSize),
                              child: Text(comment.userCreate!.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.v))),
                          subtitle: Container(
                              margin: EdgeInsets.only(top: 1.adaptSize),
                              child: Text(comment.content!.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18.v,
                                      color: Colors.black))),
                          trailing: GestureDetector(
                            onTap: () {
                              isExpanded.toggle();
                            },
                            child: Container(
                                child: (comment.countReplies?.value != 0)
                                    ? Text(
                                        'Xem\n${comment.countReplies?.value} trả lời',
                                        textAlign: TextAlign.right,
                                      )
                                    : SizedBox.shrink()),
                          ),
                          minVerticalPadding: 1.v,
                        ),
                      ),
                      if (isExpanded.value)
                        ReplyComment(replyId: comment.id!.value)
                      else
                        SizedBox.shrink()
                    ]);
                  },
                ),
              ),
            ),
            if (!commentController.replyMode)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 8.adaptSize),
                    Expanded(
                      child: Text(
                        'Chạm vào bình luận 2 lần để trả lời',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black54, fontStyle: FontStyle.italic),
                      ),
                    ),
                    SizedBox(width: 8.adaptSize),
                  ],
                ),
              ),
            if (commentController.replyMode)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 8.adaptSize),
                    Expanded(
                      child: Obx(
                        () => Text(
                          commentController.replyLabel.value.value,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () => commentController.cancelReplyMode(),
                        icon: Icon(Icons.cancel_rounded))
                  ],
                ),
              ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(children: [
                  Expanded(
                      child: CustomTextFormField(
                          controller: _textEditingController,
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
                              if (_textEditingController.text != '') {
                                handleSendButtonPressed(
                                    _textEditingController.text,
                                    commentController.replyMode);
                              }
                            },
                          )))
                ]))
          ]));
    });
  }
}

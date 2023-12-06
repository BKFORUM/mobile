import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/reply.dart';
import 'package:bkforum/widgets/comment_reply_widget.dart';
import 'package:bkforum/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/apiClient/comments_api.dart';
import '../data/models/comments_model.dart';
import '../widgets/custom_comment_screen.dart';

class CommentController extends GetxController {
  var commentsList = <CommentsModel>[].obs;
  var isExpandedList = <RxBool>[].obs;
  var replyLabel = RxString('Chạm vào bình luận 2 lần để trả lời').obs;
  String commentId = '';
  bool replyMode = false;
  TextEditingController updateCmtContent = TextEditingController();

  void fetchComments(String id) async {
    try {
      List<CommentsModel> tempList = await CommentsApiClient().fetchData(id);
      commentsList.assignAll(tempList);
      commentsList.forEach((comment) {
        isExpandedList.add(false.obs);
      });
    } catch (error) {
      print('Error fetching comments: $error');
    }
  }

  void fetchMoreComments(String id, int length) {
    int take = 10;
    int skip = length;
    CommentsApiClient().fetchData(id, take: take, skip: skip).then((value) {
      commentsList.addAll(value);
    }).catchError((error) {
      print('Error: $error');
    });
  }

  void uploadCommentOrReply(String id, String content, bool mode) {
    if (mode) {
      CommentsApiClient().uploadReply(commentId, content);
    } else {
      CommentsApiClient().uploadComment(id, content);
    }
  }

  void changeToReplyMode(CommentsModel comment) {
    replyLabel.value.value = 'Trả lời bình luận của ${comment.userCreate}';
    commentId = comment.id!.value;
    replyMode = true;
  }

  void cancelReplyMode() {
    replyMode = false;
  }

  deleteComment(CommentsModel comment) async {
    if (await CommentsApiClient().deleteComment(comment.id!.value))
      Get.snackbar('Xóa bình luận thành công', '',
          backgroundColor: Colors.amberAccent);
    else
      Get.snackbar('Xóa bình luận không thành công', '',
          backgroundColor: Colors.redAccent);
  }

  updateComment(CommentsModel comment) {
    Get.back();
    updateCmtContent.text = comment.content!.value;
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        title: Text('Chỉnh sửa'),
        content: TextField(
          controller: updateCmtContent,
          decoration: InputDecoration(
            hintText: 'Chỉnh sửa tại đây...',
          ),
        ),
        actions: [
          CustomElevatedButton(
            onTap: () async {
              Get.back();
              if (await CommentsApiClient()
                  .updateComment(comment.id!.value, updateCmtContent.text))
                Get.snackbar('Chỉnh sửa bình luận thành công', '',
                    backgroundColor: Colors.amberAccent);
              else
                Get.snackbar('Chỉnh sửa bình luận không thành công', '',
                    backgroundColor: Colors.redAccent);
            },
            text: 'Xác nhận',
          ),
        ],
      ),
    );
  }

}
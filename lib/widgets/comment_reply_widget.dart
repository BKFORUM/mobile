import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/comments_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/models/reply.dart';

// ignore: must_be_immutable
class ReplyComment extends StatelessWidget {
  final String replyId;
  final RepliesController repliesController = RepliesController();
  List<ReplyModel> repliesList = [
    ReplyModel(
      userCreate: Rx<String>("John"),
      userAvatar: Rx<String>('https://bom.so/PR608m'),
      commentId: Rx<String>('1'),
      content: Rx<String>("Hello"),
      id: Rx<String>('1'),
    ),
    ReplyModel(
      userCreate: Rx<String>("Alice"),
      userAvatar: Rx<String>('https://bom.so/PR608m'),
      commentId: Rx<String>('2'),
      content: Rx<String>("Hi"),
      id: Rx<String>('2'),
    ),
  ];
  ReplyComment({required this.replyId});
  @override
  Widget build(BuildContext context) {
    repliesController.fetchReplies(replyId).then((fetchedReplies) {
      repliesList = fetchedReplies;
    });

    // void handleSendButtonPressed(String reply) {
    //   repliesController.uploadReply(repliesList[0].commentId!.value, reply);
    //   _textEditingController.text = '';
    //   repliesController.fetchReplies(repliesList[0].commentId!.value);
    // }

    return FutureBuilder<List<ReplyModel>>(
        future: repliesController.fetchReplies(replyId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            repliesList = snapshot.data!;
            return Container(
              padding: EdgeInsets.only(left: 16.adaptSize),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(20.adaptSize))),
              child: Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: repliesList.length,
                      itemBuilder: (context, index) {
                        final reply = repliesList[index];
                        return ListTile(
                          leading: Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 8.adaptSize),
                            child: CustomImageView(
                              url: reply.userAvatar!.value,
                              fit: BoxFit.cover,
                              height: 22.adaptSize,
                              width: 22.adaptSize,
                              radius: BorderRadius.circular(14.h),
                            ),
                          ),
                          title: Container(
                            margin: EdgeInsets.fromLTRB(
                                0, 0, 4.adaptSize, 6.adaptSize),
                            child: Text(
                              reply.userCreate!.value,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.v,
                              ),
                            ),
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: 1.adaptSize),
                            child: Text(
                              reply.content!.value,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16.v,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          minVerticalPadding: 1.v,
                        );
                      }),
                ],
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(right: 12.0),
              height: 14.adaptSize,
              width: 26.adaptSize,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            );
          }
          // }
        });
  }
}

class RepliesController extends GetxController {
  var repliesList = <ReplyModel>[].obs;

  Future<List<ReplyModel>> fetchReplies(String id) async {
    try {
      List<ReplyModel> tempList = await CommentsApiClient().fetchReplies(id);
      repliesList.assignAll(tempList);
      return tempList;
    } catch (error) {
      print('Error fetching replies: $error');
      return <ReplyModel>[];
    }
  }

  void uploadReply(String id, String reply) {}
}

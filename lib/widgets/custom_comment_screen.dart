import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/custom_reaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/apiClient/comments_api.dart';
import 'custom_elevated_button.dart';
import 'custom_text_form_field.dart';
import 'custom_reaction.dart';
import '../data/models/comments_model.dart';

class CustomCommentScreen extends StatefulWidget {
  String id;

  CustomCommentScreen(this.id, {Key? key}) : super(key: key);

  @override
  _CustomCommentScreenState createState() => _CustomCommentScreenState();
}

class _CustomCommentScreenState extends State<CustomCommentScreen> {
  // double _sheetHeight = 1000.adaptSize; // Chiều cao mặc định của BottomSheet

  List<CommentsModel> commentsList = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: Fetch comments data from API and update commentsList
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      List<CommentsModel> tempList =
          await CommentsApiClient().fetchData(widget.id);
      setState(() {
        commentsList = tempList;
      });
    } catch (error) {
      print('Error fetching comments: $error');
    }
  }

  void uploadComment(String id, String comment) {
    CommentsApiClient().uploadData(id, comment);
  }

  void handleSendButtonPressed(String comment) {
    uploadComment(widget.id, comment);
    _textEditingController.text = '';
    setState(() {
      fetchComments();
    });
  }
  @override
  Widget build(BuildContext context) {
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
            )),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgIconavatar28x28,
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                        radius: BorderRadius.circular(14.h),
                      )),
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
                              if (_textEditingController.text != ''){
                                handleSendButtonPressed(
                                    _textEditingController.text);
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
        //height: 500,
        child: Flex(direction: Axis.vertical, children: [
          Expanded(
              child: ListView.builder(
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    final comment = commentsList[index];
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.adaptSize),
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
                          minVerticalPadding: 1.v,
                        ));
                  })),
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgIconavatar28x28,
                      height: 30.adaptSize,
                      width: 30.adaptSize,
                      radius: BorderRadius.circular(14.h),
                    )),
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
                            if (_textEditingController.text.trim().isNotEmpty){
                              handleSendButtonPressed(
                                  _textEditingController.text);
                            }
                          },
                        )))
              ]))
        ]));
  }
}

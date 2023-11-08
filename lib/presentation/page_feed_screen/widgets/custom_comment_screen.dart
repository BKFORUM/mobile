
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/custom_reaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/apiClient/comments_api.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/custom_reaction.dart';
import '../models/comments_model.dart';

class CustomCommentScreen extends StatefulWidget {

  String id;

  CustomCommentScreen(this.id, {Key? key}) : super(key: key);

  @override
  _CustomCommentScreenState createState() => _CustomCommentScreenState();
}

class _CustomCommentScreenState extends State<CustomCommentScreen> {
  double _sheetHeight = 1000.adaptSize; // Chiều cao mặc định của BottomSheet

  List<CommentsModel> commentsList = [];

  @override
  void initState() {
    // TODO: Fetch comments data from API and update commentsList
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      List<CommentsModel> tempList = await CommentsApiClient().fetchData(widget.id);
      setState(() {
        commentsList = tempList;
      });
    } catch (error) {
      print('Error fetching comments: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (commentsList.isEmpty){
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(10.adaptSize),
          child: Column(
            children: [
              Expanded(child: Center(
                child: Text("Ở đây chưa có bình luận nào, hãy là người đầu tiên bình luận."),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgIconavatar28x28,
                          height: 30.adaptSize,
                          width: 30.adaptSize,
                          radius: BorderRadius.circular(14.h),
                        )
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFormField(
                        //controller: ,
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
                            // Xử lý gửi bình luận ở đây
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]
        )
      );
    }
    return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.fromLTRB(
              10.adaptSize,
              10.adaptSize,
              10.adaptSize,
              10.adaptSize),
          //height: 500,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    final comment = commentsList[index];
                    return ListTile(
                      leading: CustomImageView(
                          url: comment.userAvatar!.value,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          radius: BorderRadius.circular(14.h),
                          // margin: EdgeInsets.symmetric(vertical: 1.v)
                      ),
                      title: Text(comment.userCreate!.value),
                      subtitle: Text(comment.content!.value),
                      // GestureDetector(
                      //   child: Text('Trả lời'),
                      // ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CustomReaction(),
                      ),
                      minVerticalPadding: 1.v,
                      //contentPadding: EdgeInsetsGeometry.infinity,
                    );
                  }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgIconavatar28x28,
                          height: 30.adaptSize,
                          width: 30.adaptSize,
                          radius: BorderRadius.circular(14.h),
                        )
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFormField(
                          //controller: ,
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
                            // Xử lý gửi bình luận ở đây
                            },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
  }
}
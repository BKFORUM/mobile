
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/custom_reaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/custom_reaction.dart';

class CustomCommentScreen extends StatefulWidget {
  @override
  _CustomCommentScreenState createState() => _CustomCommentScreenState();
}

class _CustomCommentScreenState extends State<CustomCommentScreen> {
  double _sheetHeight = 1000.adaptSize; // Chiều cao mặc định của BottomSheet


  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.fromLTRB(10.adaptSize, 10.adaptSize, 10.adaptSize, 10.adaptSize),
          //height: 500,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Comment $index'),
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
                          fillColor: appTheme.blueGray100
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 10.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgIconsend,
                          height: 16.adaptSize,
                          width: 16.adaptSize,
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        );
  }
}
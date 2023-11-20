import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_friends_screen/model/friends_request_model.dart';
import 'package:bkforum/presentation/page_friends_screen/widget/friend_request_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageFriendsRequest extends StatelessWidget{
   PageFriendsRequest(this.listFriendSuggest,{Key? key}): super(key: key);
   FriendsRequestModel listFriendSuggest;
     @override
     Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Lời mời kết bạn",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.h),
                          padding: EdgeInsets.symmetric(vertical: 6.v),
                          decoration: AppDecoration.fillOnErrorContainer,
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 10.v);
                              },
                              itemCount: 40,
                              itemBuilder: (context, index) {
                                FriendRequest model = this.listFriendSuggest.friendsRequest.value[0];
                                return FriendRequestWidget(model);
                              })))
                ]))
        )
      );
     }

   
}
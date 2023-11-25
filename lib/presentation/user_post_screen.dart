import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/userpost_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPostScreen extends GetView<UserPostScreenController> {
  UserPostScreen({
    Key? key,
    required String id
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          // body: UserpostItemWidget(),
        ));
  }

}

class UserPostScreenController extends GetxController{
}
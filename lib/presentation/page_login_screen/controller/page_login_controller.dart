import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_login_screen/models/page_login_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the PageLoginScreen.
///
/// This class manages the state of the PageLoginScreen, including the
/// current pageLoginModelObj
class PageLoginController extends GetxController {
  TextEditingController studentidoneController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  Rx<PageLoginModel> pageLoginModelObj = PageLoginModel().obs;

  @override
  void onClose() {
    super.onClose();
    studentidoneController.dispose();
    passwordoneController.dispose();
  }

  // @override
  // void onReady() {
  //   Future.delayed(const Duration(milliseconds: 3000), () {
  //     Get.offNamed(
  //       AppRoutes.pageFeedScreen,
  //     );
  //   });
  // }
}

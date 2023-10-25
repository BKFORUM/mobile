import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_post_screen/models/page_post_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the PagePostScreen.
///
/// This class manages the state of the PagePostScreen, including the
/// current pagePostModelObj
class PagePostController extends GetxController {
  TextEditingController forumpostoneController = TextEditingController();

  Rx<PagePostModel> pagePostModelObj = PagePostModel().obs;

  @override
  void onClose() {
    super.onClose();
    forumpostoneController.dispose();
  }
}

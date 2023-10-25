import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_message_screen/models/page_message_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the PageMessageScreen.
///
/// This class manages the state of the PageMessageScreen, including the
/// current pageMessageModelObj
class PageMessageController extends GetxController {
  TextEditingController tmkimController = TextEditingController();

  Rx<PageMessageModel> pageMessageModelObj = PageMessageModel().obs;

  @override
  void onClose() {
    super.onClose();
    tmkimController.dispose();
  }
}

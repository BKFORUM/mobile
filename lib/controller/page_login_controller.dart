import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_login_screen/models/page_login_model.dart';
import 'package:flutter/material.dart';

import '../data/apiClient/apiLogin.dart';

/// A controller class for the PageLoginScreen.
///
/// This class manages the state of the PageLoginScreen, including the
/// current pageLoginModelObj
class PageLoginController extends GetxController {
  TextEditingController studentidoneController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  Rx<PageLoginModel> pageLoginModelObj = PageLoginModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    studentidoneController.dispose();
    passwordoneController.dispose();
  }

  void loginController(String email, String password) async{
    final result = await LoginApiClient().login(email, password);
    if (result == 'Đăng nhập thất bại')
      Get.snackbar('Đăng nhập thất bại', 'Mã sinh viên, email hoặc mật khẩu không chính xác',
          colorText: Colors.red,
          icon: Icon(Icons.sms_failed_outlined),
          padding: EdgeInsets.symmetric(vertical: 30.adaptSize)
      );
    else {
      Get.offNamed(AppRoutes.pageFeedScreen);
    }
  }

}

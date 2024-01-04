import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/socket/socket.dart';
import 'package:bkforum/presentation/page_login_screen/models/page_login_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
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
      SocketIO().initSocket();
      Get.offNamed(AppRoutes.pageFeedScreen);
    }
  }

  Future<void> requestForgetPassword(String email) async {
    final forgotCheck = await LoginApiClient().requestForget(email);
    if(forgotCheck){
      String passWord = '';
      String passWordCheck = '';
      String token = '';
      RxInt countdown = 60.obs;
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Mã khôi phục được gửi đến email của bạn"
                  "\nhãy vào hòm thư để nhận mã và nhập mật khẩu mới phía dưới",
                textAlign: TextAlign.center,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  passWord = value;
                },
                decoration: InputDecoration(hintText: 'Mật khẩu mới'),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  passWordCheck = value;
                },
                decoration: InputDecoration(hintText: 'Nhập lại mật khẩu mới'),
              ),
              SizedBox(height: 20),
              Text('Mã khôi phục sẽ hết hiệu lực sau ${countdown.value}s'),
              TextField(
                onChanged: (value) {
                  token = value;
                },
                decoration: InputDecoration(hintText: 'Mã khôi phục'),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(26.adaptSize),
                      ),
                      child: Text('Xác thực', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber)),
                      onPressed: () {
                        if(passWord == passWordCheck && passWordCheck.trim().isNotEmpty
                        && token.isNotEmpty)
                        LoginApiClient().resetPassword(
                            email,
                            token,
                            passWordCheck
                        ); else Get.snackbar('Sai thông tin khôi phục',
                        'Vui lòng nhập lại thông tin khôi phục',
                            backgroundColor: Colors.amber);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(26.adaptSize),
                      ),
                      child: Text('Đăng nhập', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber)),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ]
          ),
        ),
      ));
    } else {
      Get.snackbar('Lỗi khi gửi email', 'Đã có lỗi khi gửi email. Hãy kiểm tra email của bạn',
        backgroundColor: Colors.amber
      );
    }
  }

}

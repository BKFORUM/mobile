import 'package:flutter_animate/flutter_animate.dart';

import '../../data/apiClient/apiLogin.dart';
import '../../controller/page_login_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/widgets/custom_elevated_button.dart';
import 'package:bkforum/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PageLoginScreen extends GetWidget<PageLoginController> {
  const PageLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onErrorContainer
                ),
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.only(left: 24.h, top: 70.v, right: 24.h),
                    child:
                    Animate(
                        effects: [FadeEffect(), SlideEffect(curve: Curves.easeIn)],
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              CustomImageView(
                                  imagePath: ImageConstant.imgFramebk10,
                                  height: 180.v,
                                  width: 312.h),
                              Spacer(),
                              CustomTextFormField(
                                  controller: controller.studentidoneController,
                                  contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.v),
                                  hintText: "lbl_m_sinh_vi_n".tr),
                              SizedBox(height: 24.v),
                              CustomTextFormField(
                                  controller: controller.passwordoneController,
                                  contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.v),
                                  hintText: "lbl_m_t_kh_u".tr,
                                  obscureText: true,
                                  // obscuringCharacter:'*',
                                  textInputAction: TextInputAction.done
                              ),
                              SizedBox(height: 91.v),
                              CustomElevatedButton(
                                  text: "lbl_ng_nh_p".tr,
                                  onTap: (){
                                    try {
                                      PageLoginController().loginController(
                                          controller.studentidoneController.text.toString(),
                                          controller.passwordoneController.text.toString()
                                      );
                                    } on Exception catch (e) {
                                      Get.snackbar(e.toString(), '');
                                    }
                                  }
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.h, top: 74.v, bottom: 38.v),
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "msg_b_n_qu_n_m_t_kh_u2".tr,
                                            style: CustomTextStyles
                                                .bodyMediumBlack900
                                        ),
                                        TextSpan(
                                            text: "lbl_b_m_v_o_y".tr,
                                            style: CustomTextStyles
                                                .bodyMediumBlack900
                                                .copyWith(
                                                decoration:
                                                TextDecoration.underline))
                                      ]),
                                      textAlign: TextAlign.left))
                            ]
                        )
                    ),
                )
            )
        )
    );
  }
}


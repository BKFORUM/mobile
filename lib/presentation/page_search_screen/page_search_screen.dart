import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_search_screen/controller/page_search_controller.dart';
import 'package:bkforum/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/appbar_circleimage.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_image_1.dart';

class PageSearchScreen extends GetWidget<PageSearchController>{

  const PageSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            leadingWidth: 44.h,
            leading: AppbarImage(
                imagePath: ImageConstant.imgIconhome,
                margin:
                EdgeInsets.only(left: 24.h, top: 15.v, bottom: 15.v),
                onTap: () {
                  onTapIconhomeone();
                }),
              title: Padding(
                  padding: EdgeInsets.only(left: 19.h),
                  child: Row(children: [
                    AppbarImage1(
                        imagePath: ImageConstant.imgIconWhiteSearch,
                        margin: EdgeInsets.only(left: 19.h, right: 19.h),
                        onTap: () {

                        }).animate().tint(color: Colors.amber).shake(),
                    AppbarImage1(
                        imagePath: ImageConstant.imgIconadd,
                        margin: EdgeInsets.only(left: 19.h, right: 19.h),
                        onTap: () {
                          onTapIconaddone();
                        }),
                    AppbarImage1(
                        imagePath: ImageConstant.imgIconmessage,
                        margin: EdgeInsets.only(left: 19.h, right: 19.h),
                        onTap: () {
                          onTapIconmessageone();
                        }),
                    AppbarImage1(
                        imagePath: ImageConstant.imgIconnotification,
                        margin: EdgeInsets.only(left: 19.h, right: 19.h),
                        onTap: () {
                          onTapNotificationdet();
                        }
                    ),
                    AppbarImage1(
                        imagePath: ImageConstant.imgIconMenu,
                        margin: EdgeInsets.only(left: 19.h, right: 19.h),
                        onTap: () {
                          onTapIconavatarone();
                        })
                  ])),
              styleType: Style.bgFill
          ),
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillOnErrorContainer,
                child:
                Expanded(child: Container())
            )
        )

    );
  }

}

/// Navigates to the pageFeedScreen when the action is triggered.

/// When the action is triggered, this function uses the [Get] package to
/// push the named route for the pageFeedScreen.
onTapIconhomeone() {
  Get.toNamed(
    AppRoutes.pageFeedScreen,
  );
}

/// Navigates to the pageForumoneScreen when the action is triggered.

/// When the action is triggered, this function uses the [Get] package to
/// push the named route for the pageForumoneScreen.
onTapIconforumone() {
  Get.toNamed(
    AppRoutes.pageForumoneScreen,
  );
}

/// Navigates to the pageMessageScreen when the action is triggered.

/// When the action is triggered, this function uses the [Get] package to
/// push the named route for the pageMessageScreen.
onTapIconmessageone() {
  Get.toNamed(
    AppRoutes.pageMessageScreen,
  );
}

/// Navigates to the pagePostScreen when the action is triggered.

/// When the action is triggered, this function uses the [Get] package to
/// push the named route for the pagePostScreen.
onTapIconaddone() {
  Get.toNamed(
    AppRoutes.pagePostScreen,
  );
}

/// Navigates to the pageSettingScreen when the action is triggered.

/// When the action is triggered, this function uses the [Get] package to
/// push the named route for the pageSettingScreen.
onTapIconavatarone() {
  Get.toNamed(
    AppRoutes.pageSettingScreen,
  );
}

/// Navigates to the pageForumoneScreen when the action is triggered.

/// When the action is triggered, this function uses the [Get] package to
/// push the named route for the pageForumoneScreen.
onTapNotificationdet() {
  Get.toNamed(
    AppRoutes.pageNotificationScreen,
  );
}

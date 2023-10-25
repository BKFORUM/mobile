import '../controller/page_forumone_controller.dart';
import '../models/userpost1_item_model.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Userpost1ItemWidget extends StatelessWidget {
  Userpost1ItemWidget(
    this.userpost1ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Userpost1ItemModel userpost1ItemModelObj;

  var controller = Get.find<PageForumoneController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.v),
      decoration: AppDecoration.outlineGray,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: AppDecoration.fillOnErrorContainer,
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIconavatar,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  radius: BorderRadius.circular(
                    10.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.h,
                    top: 2.v,
                  ),
                  child: Text(
                    "msg_nguy_n_nh_t_h_ng".tr,
                    style: CustomTextStyles.titleSmallRobotoBlack900,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    "msg_l_p_sinh_ho_t_20tclc_dt4".tr,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 354.h,
            padding: EdgeInsets.symmetric(
              horizontal: 6.h,
              vertical: 2.v,
            ),
            decoration: AppDecoration.fillOnErrorContainer,
            child: Padding(
              padding: EdgeInsets.only(right: 8.h),
              child: Text(
                "msg_kh_ng_kh_ng_y_nh_p".tr,
                maxLines: 11,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage,
            height: 265.v,
            width: 354.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 2.v,
              width: 9.h,
              decoration: BoxDecoration(
                color: appTheme.blueGray100,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 14.h,
              top: 13.v,
            ),
            child: Row(
              children: [
                CustomImageView(
                  svgPath: ImageConstant.imgLocation,
                  height: 12.v,
                  width: 14.h,
                  margin: EdgeInsets.only(bottom: 2.v),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Text(
                    "lbl_40_y_u_th_ch".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                CustomImageView(
                  svgPath: ImageConstant.imgCar,
                  height: 14.adaptSize,
                  width: 14.adaptSize,
                  margin: EdgeInsets.only(left: 13.h),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Text(
                    "lbl_15_b_nh_lu_n".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 7.v),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 7.v,
            ),
            decoration: AppDecoration.fillOnErrorContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 7.v),
                Text(
                  "lbl_xem_b_nh_lu_n".tr,
                  style: CustomTextStyles.bodyMediumGray500,
                ),
                SizedBox(height: 12.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgIconavatar16x16,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      radius: BorderRadius.circular(
                        8.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text(
                        "msg_th_m_b_nh_lu_n".tr,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Spacer(),
                    CustomImageView(
                      imagePath: ImageConstant.imgIconsend,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

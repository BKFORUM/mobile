import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_feed_screen/models/page_feed_model.dart';
import 'package:flutter/material.dart';

import '../data/apiClient/userpost_item_api.dart';

/// A controller class for the PageFeedScreen.
///
/// This class manages the state of the PageFeedScreen, including the
/// current pageFeedModelObj
class PageFeedController extends GetxController {
  Rx<PageFeedModel> pageFeedModelObj = PageFeedModel().obs;
  void refreshPageFeedData() {
    pageFeedModelObj.value = PageFeedModel();
  }
  void deleteConfirmDialog(String id){
    Get.defaultDialog(
      title: 'Xác nhận xóa',
      content: Text('Bạn có chắc chắn muốn xóa?'),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(30.adaptSize),
        ),
        onPressed: () async {
          Get.back();
          Get.dialog(
            Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false,
          );
          bool deleted = await PostItemApiClient().deletePost(id);
          Get.back();
          if (deleted) {
            Get.snackbar(
              'Xóa thành công',
              'Bài viết đã được xóa thành công.',
              backgroundColor: Colors.amberAccent
            );
          } else {
            Get.snackbar(
              'Xóa không thành công',
              'Đã xảy ra lỗi khi xóa bài viết.',
                backgroundColor: Colors.deepOrange
            );
          }
        },
        child: Text('Có', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber),),
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(30.adaptSize),
        ),
        onPressed: () {
          Get.back();
        },
        child: Text('Không', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber),),
      ),
    );
  }
}


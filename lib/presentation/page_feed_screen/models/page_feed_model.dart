import 'dart:async';

import '../../../core/app_export.dart';
import '../../../data/apiClient/userpost_item_api.dart';
import 'userpost_item_model.dart';

/// This class defines the variables used in the [page_feed_screen],
/// and is typically used to hold data that is passed between different parts of the application.

class PageFeedModel {
  Future<List<UserpostItemModel>> loadPost() async {
    try {
      final apiClient = PostItemApiClient();
      final response = await apiClient.fetchData();
      List<UserpostItemModel> userpostItemList = [];
      for (var res in response.data) {
        UserpostItemModel userpostItem = UserpostItemModel(
          userCreate: Rx(res.user.fullName),
          userAvatar: Rx(res.user.avatarUrl),
          forumName: Rx(res.forum.name),
          postContent: Rx(res.content),
          id: Rx(res.id),
        );
        List<String> fileUrls = [];
        for (var document in res.documents) {
          fileUrls.add(document.fileUrl);
        }
        userpostItem.listImages = RxList<String>(fileUrls);

        userpostItemList.add(userpostItem);
      }
      return userpostItemList;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Rx<List<UserpostItemModel>> userpostItemList = Rx<List<UserpostItemModel>>([]);

  PageFeedModel() {
    loadPost().then((value) {
      userpostItemList.update((list) {
        list!.addAll(value);
      });
    });
  }
}

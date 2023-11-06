import 'dart:async';

import '../../../core/app_export.dart';
import '../../../data/apiClient/userpost_item_api.dart';
import 'userpost_item_model.dart';

/// This class defines the variables used in the [page_feed_screen],
/// and is typically used to hold data that is passed between different parts of the application.

class PageFeedModel {
  Rx<List<UserpostItemModel>> userpostItemList = Rx(List.generate(loadPost(), (index) => UserpostItemModel()));
  int loadPost() {
    try {
      final apiClient = PostItemApiClient();
      apiClient.fetchData().then((response) {
        final postCount = response.totalRecords ?? 1;
        return postCount;
      }).catchError((error) {
        print(error);
      });
    } on Exception catch (e) {
      // TODO
    }
  }
}

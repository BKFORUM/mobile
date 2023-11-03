import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_feed_screen/models/page_feed_model.dart';

import '../../../data/apiClient/userpost_item_api.dart';

/// A controller class for the PageFeedScreen.
///
/// This class manages the state of the PageFeedScreen, including the
/// current pageFeedModelObj
class PageFeedController extends GetxController {
  Rx<PageFeedModel> pageFeedModelObj = PageFeedModel().obs;
}

void loadPost() async {
  final apiClient = PostItemApiClient();
  await apiClient.fetchData().then((response) {
    print(response.data[0].forum.name);
    print(response.data[0].user.fullName);
    print(response.data[0].content);
  }).catchError((error) {
    print(error);
  });
}

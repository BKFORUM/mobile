import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_feed_screen/models/page_feed_model.dart';

import '../../../data/apiClient/userpost_item_api.dart';

/// A controller class for the PageFeedScreen.
///
/// This class manages the state of the PageFeedScreen, including the
/// current pageFeedModelObj
class UserPostItemController extends GetxController {
  Rx<PageFeedModel> pageFeedModelObj = PageFeedModel().obs;
}

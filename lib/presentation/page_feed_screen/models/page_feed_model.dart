import '../../../core/app_export.dart';
import 'userpost_item_model.dart';

/// This class defines the variables used in the [page_feed_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PageFeedModel {
  Rx<List<UserpostItemModel>> userpostItemList =
      Rx(List.generate(4, (index) => UserpostItemModel()));
}

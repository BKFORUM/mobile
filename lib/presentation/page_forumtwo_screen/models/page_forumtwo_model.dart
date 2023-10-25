import '../../../core/app_export.dart';
import 'post_item_model.dart';

/// This class defines the variables used in the [page_forumtwo_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PageForumtwoModel {
  Rx<List<PostItemModel>> postItemList =
      Rx(List.generate(4, (index) => PostItemModel()));
}

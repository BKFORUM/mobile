import '../../../core/app_export.dart';
import 'userpost1_item_model.dart';

/// This class defines the variables used in the [page_forumone_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PageForumoneModel {
  Rx<List<Userpost1ItemModel>> userpost1ItemList =
      Rx(List.generate(4, (index) => Userpost1ItemModel()));
}

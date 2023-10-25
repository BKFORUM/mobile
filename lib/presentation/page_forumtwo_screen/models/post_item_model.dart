import '../../../core/app_export.dart';

/// This class is used in the [post_item_widget] screen.
class PostItemModel {
  PostItemModel({this.id}) {
    id = id ?? Rx("");
  }

  Rx<String>? id;
}

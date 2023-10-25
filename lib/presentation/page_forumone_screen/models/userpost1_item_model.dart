import '../../../core/app_export.dart';

/// This class is used in the [userpost1_item_widget] screen.
class Userpost1ItemModel {
  Userpost1ItemModel({this.id}) {
    id = id ?? Rx("");
  }

  Rx<String>? id;
}

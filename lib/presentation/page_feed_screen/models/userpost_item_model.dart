import '../../../core/app_export.dart';

/// This class is used in the [userpost_item_widget] screen.
class UserpostItemModel {
  UserpostItemModel({
    this.userCreate,
    this.forumName,
    this.postContent,
    this.id,
  }) {
    userCreate = userCreate ?? Rx("Tác giả");
    forumName = forumName ?? Rx("Lớp sinh hoạt");
    postContent = postContent ?? Rx("...");
    id = id ?? Rx("...");
  }
  Rx<String>? userCreate;

  Rx<String>? forumName;

  Rx<String>? postContent;

  Rx<String>? id;
}

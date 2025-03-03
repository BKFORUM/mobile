import '../../core/app_export.dart';

/// This class is used in the [custom_comment_screen] screen.
class CommentsModel {
  CommentsModel({
    this.userCreate,
    this.userAvatar,
    this.content,
    this.countReplies,
    this.id,

  }) {
    userCreate = userCreate ?? Rx("người dùng");
    userAvatar = userAvatar ?? Rx('https://bom.so/SjYyN2');
    content = content ?? Rx("...");
    countReplies = countReplies ?? Rx(0);
    id = id ?? Rx("...");
  }
  Rx<String>? userCreate;

  Rx<String>? userAvatar;

  Rx<String>? content;

  Rx<int>? countReplies;

  Rx<String>? id;
}

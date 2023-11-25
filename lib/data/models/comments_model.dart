import '../../core/app_export.dart';

/// This class is used in the [custom_comment_screen] screen.
class CommentsModel {
  CommentsModel({
    this.userCreate,
    this.userAvatar,
    this.content,
    this.id,
  }) {
    userCreate = userCreate ?? Rx("người dùng");
    userAvatar = userAvatar ?? Rx('https://inkythuatso.com/uploads/thumbnails/800/2023/03/9-anh-dai-dien-trang-inkythuatso-03-15-27-03.jpg');
    content = content ?? Rx("...");
    id = id ?? Rx("...");
  }
  Rx<String>? userCreate;

  Rx<String>? userAvatar;

  Rx<String>? content;

  Rx<String>? id;
}

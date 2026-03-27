import '../../core/app_export.dart';

class ReplyModel {
  ReplyModel({
    this.userCreate,
    this.userAvatar,
    this.commentId,
    this.content,
    this.id,

  }) {
    userCreate = userCreate ?? Rx("người dùng");
    userAvatar = userAvatar ?? Rx('https://bom.so/SjYyN2');
    commentId = commentId ?? Rx('');
    content = content ?? Rx("...");
    id = id ?? Rx("...");
  }
  Rx<String>? userCreate;
  Rx<String>? userAvatar;
  Rx<String>? commentId;
  Rx<String>? content;
  Rx<String>? id;
}
import '../../../core/app_export.dart';

/// This class is used in the [userpost_item_widget] screen.
class UserpostItemModel {
  UserpostItemModel({
    this.userCreate,
    this.userAvatar,
    this.forumName,
    this.postContent,
    this.listImages,
    this.id,
  }) {
    userCreate = userCreate ?? Rx("Tác giả");
    userAvatar = userAvatar ?? Rx('https://inkythuatso.com/uploads/thumbnails/800/2023/03/9-anh-dai-dien-trang-inkythuatso-03-15-27-03.jpg');
    forumName = forumName ?? Rx("Lớp sinh hoạt");
    postContent = postContent ?? Rx("...");
    listImages = listImages ?? RxList<String>([]);
    id = id ?? Rx("...");
  }
  Rx<String>? userCreate;

  Rx<String>? userAvatar;

  Rx<String>? forumName;

  Rx<String>? postContent;

  RxList<String>? listImages;

  Rx<String>? id;
}

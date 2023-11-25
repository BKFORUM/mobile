import '../../core/app_export.dart';

/// This class is used in the [userpost_item_widget] screen.
class UserpostItemModel {
  UserpostItemModel({
    this.userCreateId,
    this.userCreate,
    this.userAvatar,
    this.forumModId,
    this.forumName,
    this.postContent,
    this.listImages,
    this.createdAt,
    this.id,
  }) {
    userCreateId = userCreateId ?? Rx("Id Tác giả");
    userCreate = userCreate ?? Rx("Tác giả");
    userAvatar = userAvatar ?? Rx('https://inkythuatso.com/uploads/thumbnails/800/2023/03/9-anh-dai-dien-trang-inkythuatso-03-15-27-03.jpg');
    forumModId = forumModId ?? Rx('default mod id');
    forumName = forumName ?? Rx("Lớp sinh hoạt");
    postContent = postContent ?? Rx("...");
    listImages = listImages ?? RxList<String>([]);
    createdAt = createdAt ?? Rx<DateTime>(DateTime.now());
    id = id ?? Rx("...");
  }
  Rx<String>? userCreateId;

  Rx<String>? userCreate;

  Rx<String>? userAvatar;

  Rx<String>? forumName;

  Rx<String>? forumModId;

  Rx<String>? postContent;

  RxList<String>? listImages;

  Rx<DateTime>? createdAt;

  Rx<String>? id;
}

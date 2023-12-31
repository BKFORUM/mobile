import '../../core/app_export.dart';
import 'data_prop/document.dart';

/// This class is used in the [userpost_item_widget] screen.
class UserpostItemModel {
  UserpostItemModel({
    this.userCreateId,
    this.userCreate,
    this.userAvatar,
    this.forumModId,
    this.forumId,
    this.forumName,
    this.forumModName,
    this.postContent,
    this.listImages,
    this.document,
    this.createdAt,
    this.likedAt,
    this.countLikes,
    this.countComments,
    this.status,
    this.id,
  }) {
    userCreateId = userCreateId ?? Rx("Id Tác giả");
    userCreate = userCreate ?? Rx("Tác giả");
    userAvatar = userAvatar ?? Rx('https://bom.so/SjYyN2');
    forumId = forumId ?? Rx('forum id');
    forumName = forumName ?? Rx("Lớp sinh hoạt");
    forumModName = forumModName ?? Rx("");
    forumModId = forumModId ?? Rx('default mod id');
    postContent = postContent ?? Rx("...");
    listImages = listImages ?? RxList<String>([]);
    document = document ?? RxList(<PostDocument>[]);
    createdAt = createdAt ?? Rx<DateTime>(DateTime.now());
    likedAt = likedAt ?? Rx<DateTime>(DateTime.now());
    countLikes = countLikes ?? Rx(0);
    countComments = countComments ?? Rx(0);
    status = status ?? Rx('ACTIVE');
    id = id ?? Rx("...");
  }
  Rx<String>? userCreateId;

  Rx<String>? userCreate;

  Rx<String>? userAvatar;

  Rx<String>? forumName;

  Rx<String>? forumModName;

  Rx<String>? forumId;

  Rx<String>? forumModId;

  Rx<String>? postContent;

  RxList<String>? listImages;

  RxList<PostDocument>? document;

  Rx<DateTime>? createdAt;

  Rx<DateTime>? likedAt;

  Rx<int>? countLikes;

  Rx<int>? countComments;

  Rx<String>? status;

  Rx<String>? id;
}

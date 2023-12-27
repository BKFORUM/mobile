import 'dart:io';

import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/forum_list_api.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:bkforum/data/models/topic.dart';
import 'package:bkforum/presentation/page_forumone_screen/models/page_forumone_model.dart';

import 'package:bkforum/data/models/data_prop/forum.dart';

import '../core/utils/conpress_image.dart';
import '../data/apiClient/event_api_client.dart';
import '../data/apiClient/upload_image.dart';
import '../data/apiClient/userpost_item_api.dart';
import '../data/models/data_prop/document.dart';
import '../data/models/data_prop/users.dart';
import '../data/models/profile_model.dart';
import '../data/models/userpost_item_model.dart';

/// A controller class for the PageForumoneScreen.
///
/// This class manages the state of the PageForumoneScreen, including the
/// current pageForumoneModelObj
class PageForumoneController extends GetxController {
  var selectedForum = Forum(id: '', name: '', modName: 'Unknown').obs;
  Forum get getSelectedForum => selectedForum.value;
  var posts = [];
  RxList<Profile> userResults = <Profile>[].obs;
  var eventsList = <Event>[].obs;

  Rx<PageForumoneModel> getPostsByForumId(String forumId) {
    Rx<PageForumoneModel> pageForumoneModelObj =
        Rx<PageForumoneModel>(PageForumoneModel(forumId));

    pageForumoneModelObj.value.loadForumPost(forumId).then((value) {
      // ignore: invalid_use_of_protected_member
      pageForumoneModelObj.value.userpostForumItemList.value.addAll(value);
      // ignore: invalid_use_of_protected_member
      print(pageForumoneModelObj.value.userpostForumItemList.value.length);
    });

    return pageForumoneModelObj;
  }

  getUsersOfForum() {}

  Future<List<UserpostItemModel>> loadForumPost(final String forumId) async {
    try {
      final apiClient = PostItemApiClient();
      final response = await apiClient.fetchData(forumId, 10, 0);
      List<UserpostItemModel> userpostItemList = [];
      for (var res in response.data) {
        UserpostItemModel userpostItem = UserpostItemModel(
          userCreateId: Rx(res.user.id),
          userCreate: Rx(res.user.fullName),
          userAvatar: Rx(res.user.avatarUrl),
          forumModId: Rx(res.forum.modId),
          forumName: Rx(res.forum.name),
          postContent: Rx(res.content),
          document: RxList<PostDocument>(res.documents),
          createdAt: Rx(res.createdAt),
          likedAt: Rx(res.likedAt ?? DateTime.now()),
          countLikes: Rx(res.count.likes),
          countComments: Rx(res.count.comments),
          id: Rx(res.id),
        );

        List<String> fileUrls = [];
        for (var document in res.documents) {
          fileUrls.add(document.fileUrl);
        }

        userpostItem.listImages = RxList<String>(fileUrls);
        userpostItemList.add(userpostItem);
      }

      return userpostItemList;
    } catch (error) {
      print(error);
      throw error;
    }
  }
  Future<List<UserpostItemModel>> fetchMorePosts(String forumId, int length) async {
    try {
      final apiClient = PostItemApiClient();
      final response = await apiClient.fetchData(forumId, 10, length);
      List<UserpostItemModel> userpostItemList = [];
      for (var res in response.data) {
        UserpostItemModel userpostItem = UserpostItemModel(
          userCreateId: Rx(res.user.id),
          userCreate: Rx(res.user.fullName),
          userAvatar: Rx(res.user.avatarUrl),
          forumModId: Rx(res.forum.modId),
          forumName: Rx(res.forum.name),
          postContent: Rx(res.content),
          document: RxList<PostDocument>(res.documents),
          createdAt: Rx(res.createdAt),
          likedAt: Rx(res.likedAt ?? DateTime.now()),
          countLikes: Rx(res.count.likes),
          countComments: Rx(res.count.comments),
          id: Rx(res.id),
        );

        List<String> fileUrls = [];
        for (var document in res.documents) {
          fileUrls.add(document.fileUrl);
        }

        userpostItem.listImages = RxList<String>(fileUrls);
        userpostItemList.add(userpostItem);
      }

      return userpostItemList;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<List<UserpostItemModel>> loadRequestPost(String forumId) async {
    try {
      final apiClient = PostItemApiClient();
      final response = await apiClient.getRequestPost(forumId, 10, 0);
      List<UserpostItemModel> userpostItemList = [];
      for (var res in response.data) {
        UserpostItemModel userpostItem = UserpostItemModel(
          userCreateId: Rx(res.user.id),
          userCreate: Rx(res.user.fullName),
          userAvatar: Rx(res.user.avatarUrl),
          forumModId: Rx(res.forum.modId),
          forumName: Rx(res.forum.name),
          postContent: Rx(res.content),
          document: RxList<PostDocument>(res.documents),
          createdAt: Rx(res.createdAt),
          likedAt: Rx(res.likedAt ?? DateTime.now()),
          countLikes: Rx(res.count.likes),
          countComments: Rx(res.count.comments),
          id: Rx(res.id),
        );

        List<String> fileUrls = [];
        for (var document in res.documents) {
          fileUrls.add(document.fileUrl);
        }

        userpostItem.listImages = RxList<String>(fileUrls);
        userpostItemList.add(userpostItem);
      }

      return userpostItemList;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<List<Event>> loadForumEvents(String id) async {
    try {
      List<Event> tempList = await EventApiClient().fetchData(forumIds: id);
      eventsList.assignAll(tempList);
      return eventsList;
    } catch (error) {
      print('Error fetching forum event: $error');
      throw error;
    }
  }

  Future<bool> leaveForum(String forumId) {
    return ForumListApiClient().leaveForum(forumId);
  }


  // Xu ly xoa member
  Future<bool> kickUser(String? userId, String forumId) {
    return ForumListApiClient().kickUserFromForum(userId, forumId);
  }

  Future<List<Topic>> getAllTopics() async{
    try{
      List<Topic> tempList = await ForumListApiClient().fetchTopics();
      return tempList;
    }  catch (error) {
      print('Error fetching topic: $error');
      throw error;
    }
  }

  Future<void> createForum(String forumName, RxList<Topic> topics, File? value) async {
    if (value!.isAbsolute) {
      final compressedItem = await testCompressAndGetFile(value, "compressed_");
      PostDocument document = await uploadImage(compressedItem);
      ForumListApiClient().createForum(forumName, topics, document.fileUrl);
    } else {
      ForumListApiClient().createForum(forumName, topics, null);
    }
  }
  Future<void> editForum(String forumName, RxList<Topic> topics, File? value, String? avatarUrl, String? forumId) async{
    if (value!.isAbsolute) {
      final compressedItem = await testCompressAndGetFile(value, "compressed_");
      PostDocument document = await uploadImage(compressedItem);
      ForumListApiClient().updateForum(forumName, topics, document.fileUrl, forumId);
    } else {
      ForumListApiClient().updateForum(forumName, topics, avatarUrl, forumId);
    }
  }
  void changeRequestStatus(Forum forum) {
    if(forum.yourStatus == "PENDING"){
      ForumListApiClient().undoRequest(forum);
    } else ForumListApiClient().makeRequest(forum);
  }

  Future<List<Profile>> getAllUser() async {
    final tempList = await ForumListApiClient().searchUsers('');
    return tempList;
  }

  Future<void> acceptRequestPost(UserpostItemModel post) async {
    await PostItemApiClient().acceptOrRejectRequestPost(post, true);
  }
  Future<void> rejectRequestPost(UserpostItemModel post) async {
    await PostItemApiClient().acceptOrRejectRequestPost(post, false);
  }



}
class MemberController extends GetxController{
  RxList<Profile> addedUsers = <Profile>[].obs;
  List<Profile> users = [];

  void addUsersToForum(RxList<Profile> addedUsers, Forum forum) {
    ForumListApiClient().addUsersToForum(addedUsers, forum);
  }

  Future<void> acceptRequestMember(Profile user, Forum forum) async {
    await ForumListApiClient().acceptOrRejectRequestMember(user, forum, true);
  }
  Future<void> rejectRequestMember(Profile user, Forum forum) async {
    await ForumListApiClient().acceptOrRejectRequestMember(user, forum, false);
  }
  Future<List<Profile>> loadRequestUsers(String forumId) async {
    List<Profile> userList = [];
    userList = await ForumListApiClient().getMemberRequest(forumId);
    return userList;
  }
}

import 'dart:async';

import 'package:bkforum/data/models/data_prop/document.dart';

import '../../../core/app_export.dart';
import '../../../data/apiClient/userpost_item_api.dart';
import '../../../data/models/userpost_item_model.dart';

/// This class defines the variables used in the [page_feed_screen],
/// and is typically used to hold data that is passed between different parts of the application.

class PageFeedModel {
  Future<List<UserpostItemModel>> loadPost() async {
    try {
      final apiClient = PostItemApiClient();
      final response = await apiClient.fetchData('', 10, 0);
      List<UserpostItemModel> userpostItemList = [];
      for (var res in response.data) {
        UserpostItemModel userpostItem = UserpostItemModel(
          userCreateId: Rx(res.user.id),
          userCreate: Rx(res.user.fullName),
          userAvatar: Rx(res.user.avatarUrl),
          forumModId: Rx(res.forum.modId),
          forumId: Rx(res.forum.id),
          forumModName: Rx(res.forum.modName),
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

  Rx<List<UserpostItemModel>> userpostItemList = Rx<List<UserpostItemModel>>([]);

  PageFeedModel() {
    loadPost().then((value) {
      userpostItemList.update((list) {
        list!.addAll(value);
      });
    });
  }
  int loadedPosts = 0;
  Future<void> fetchMorePosts(int loaded) async {
    int take = 10;
    int skip = loaded;
    final apiClient = PostItemApiClient();
    try {
      final response = await apiClient.fetchData('', take, skip);
      List<UserpostItemModel> newUserpostItemList = [];
      for (var res in response.data) {
        UserpostItemModel userpostItem = UserpostItemModel(
          userCreateId: Rx(res.user.id),
          userCreate: Rx(res.user.fullName),
          userAvatar: Rx(res.user.avatarUrl),
          forumModId: Rx(res.forum.modId),
          forumName: Rx(res.forum.name),
          forumId: Rx(res.forum.id),
          forumModName: Rx(res.forum.modName),
          postContent: Rx(res.content),
          document: RxList<PostDocument>(res.documents),
          createdAt: Rx(res.createdAt),
          likedAt: Rx(res.likedAt),
          countLikes: Rx(res.count.likes),
          countComments: Rx(res.count.comments),
          id: Rx(res.id),
        );
        List<String> fileUrls = [];
        for (var document in res.documents) {
          fileUrls.add(document.fileUrl);
        }
        userpostItem.listImages = RxList<String>(fileUrls);
        newUserpostItemList.add(userpostItem);
      }

      userpostItemList.update((list) {
        list!.addAll(newUserpostItemList);
      });
      loadedPosts += newUserpostItemList.length;

    } on Exception catch (e) {
      print(e);
    }
  }
}

import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_forumone_screen/models/page_forumone_model.dart';

import 'package:bkforum/data/models/data_prop/forum.dart';

import '../data/apiClient/userpost_item_api.dart';
import '../data/models/data_prop/document.dart';
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

  Rx<PageForumoneModel> getPostsByForumId(String forumId) {
    Rx<PageForumoneModel> pageForumoneModelObj = Rx<PageForumoneModel>(PageForumoneModel(forumId));

    pageForumoneModelObj.value.loadForumPost(forumId).then((value) {
      // ignore: invalid_use_of_protected_member
      pageForumoneModelObj.value.userpostForumItemList.value.addAll(value);
      print(pageForumoneModelObj.value.userpostForumItemList.value.length);
    });

    return pageForumoneModelObj;
  }

  getUsersOfForum(){

  }

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
        // print(userpostItem.forumName);
        userpostItemList.add(userpostItem);
      }
      // print(userpostItemList.length);
      return userpostItemList;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}

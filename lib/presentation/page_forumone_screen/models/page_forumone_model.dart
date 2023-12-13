import '../../../core/app_export.dart';
import '../../../data/apiClient/userpost_item_api.dart';
import '../../../data/models/data_prop/document.dart';
import '../../../data/models/userpost_item_model.dart';


/// This class defines the variables used in the [page_forumone_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PageForumoneModel {

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
      // print(userpostItemList.length);
      return userpostItemList;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // Rx<List<UserpostItemModel>> userpostForumItemList = Rx<List<UserpostItemModel>>([]);

  var userpostForumItemList = List<UserpostItemModel>.empty().obs;

  PageForumoneModel(String forumId) {
    loadForumPost(forumId).then((value) {
      // ignore: invalid_use_of_protected_member
      userpostForumItemList.value.addAll(value);
    });
  }
}

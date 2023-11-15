import '../../../core/app_export.dart';
import '../../../data/apiClient/userpost_item_api.dart';
import '../../page_feed_screen/models/data_prop/forum.dart';
import '../../page_feed_screen/models/userpost_item_model.dart';
import 'userpost1_item_model.dart';

/// This class defines the variables used in the [page_forumone_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PageForumoneModel {
  Future<List<UserpostItemModel>> loadForumPost(final String forumId) async {
    try {
      final apiClient = PostItemApiClient();
      final response = await apiClient.fetchData(forumId);
      List<UserpostItemModel> userpostItemList = [];
      for (var res in response.data) {
        UserpostItemModel userpostItem = UserpostItemModel(
          userCreate: Rx(res.user.fullName),
          userAvatar: Rx(res.user.avatarUrl),
          forumName: Rx(res.forum.name),
          postContent: Rx(res.content),
          id: Rx(res.id),
        );
        List<String> fileUrls = [];
        for (var document in res.documents) {
          fileUrls.add(document.fileUrl);
        }
        userpostItem.listImages = RxList<String>(fileUrls);
        // print(userpostItem.postContent);
        userpostItemList.add(userpostItem);
      }
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
      userpostForumItemList.value.addAll(value);
    });
  }
}

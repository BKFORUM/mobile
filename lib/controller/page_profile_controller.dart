import 'package:bkforum/core/app_export.dart';
import '../data/apiClient/userpost_item_api.dart';
import '../data/models/profile_model.dart';
import '../data/models/userpost_item_model.dart';

class PageProfileController extends GetxController {

  late Profile userProfile;

  Rx<List<UserpostItemModel>> userpostItemList = Rx<List<UserpostItemModel>>([]);
  // Rx<PageProfileModel> pageProfileModelObj = PageProfileModel(userProfile.id).obs;

  @override
  void onInit() {
    super.onInit();
    loadPost(userProfile.id).then((value) {
      userpostItemList.update((list) {
        list!.addAll(value);
      });
    });

  }
  PageProfileController(this.userProfile);

  void refreshPostData() {
  }

  Future<List<UserpostItemModel>> loadPost(String id) async {
    try {
      final apiClient = PostItemApiClient();
      final response = await apiClient.fetchUserPostData(userProfile.id, 10, 0);
      List<UserpostItemModel> userpostItemList = [];
      for (final res in response.data) {
        UserpostItemModel userpostItem = UserpostItemModel(
          userCreateId: Rx(res.user.id),
          userCreate: Rx(res.user.fullName),
          userAvatar: Rx(res.user.avatarUrl),
          forumModId: Rx(res.forum.modId),
          forumName: Rx(res.forum.name),
          postContent: Rx(res.content),
          createdAt: Rx(res.createdAt),
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
  Future<int> getNumberOfPosts(String id) async {
    final apiClient = PostItemApiClient();
    final response = await apiClient.fetchUserPostData(userProfile.id, 10, 0);
    return response.totalRecords;
  }
  int loadedPosts = 0;
  Future<List<UserpostItemModel>> fetchMorePosts(String id, int loaded) async {
    int take = 10;
    int skip = loaded;
    final apiClient = PostItemApiClient();

    try {
      final response = await apiClient.fetchUserPostData(userProfile.id, take, skip);
      List<UserpostItemModel> newUserpostItemList = [];
      for (var res in response.data) {
        UserpostItemModel userpostItem = UserpostItemModel(
          userCreateId: Rx(res.user.id),
          userCreate: Rx(res.user.fullName),
          userAvatar: Rx(res.user.avatarUrl),
          forumModId: Rx(res.forum.modId),
          forumName: Rx(res.forum.name),
          postContent: Rx(res.content),
          createdAt: Rx(res.createdAt),
          id: Rx(res.id),
        );
        List<String> fileUrls = [];
        for (var document in res.documents) {
          fileUrls.add(document.fileUrl);
        }
        userpostItem.listImages = RxList<String>(fileUrls);

        newUserpostItemList.add(userpostItem);
      }
      return newUserpostItemList;

      // userpostItemList.update((list) {
      //   list!.addAll(newUserpostItemList);
      // });
      // loadedPosts += newUserpostItemList.length;

    } on Exception catch (e) {
      print(e);
      return [] ;
    }
  }



}

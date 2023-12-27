import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/forum_list_api.dart';
import 'package:bkforum/data/apiClient/friends_api_client.dart';
import '../data/apiClient/userpost_item_api.dart';
import '../data/models/data_prop/document.dart';
import '../data/models/data_prop/forum.dart';
import '../data/models/profile_model.dart';
import '../data/models/userpost_item_model.dart';

class PageProfileController extends GetxController {

  late Profile userProfile;

  Rx<List<UserpostItemModel>> userpostItemList = Rx<List<UserpostItemModel>>([]);
  RxList<Forum> forumResults = <Forum>[].obs;

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
  Future<List<Forum>> loadForums(String id) async {
    final response = await ForumListApiClient().fetchForumOfUsers(id);
    return response;
  }
  Future<int> getNumberOfPosts(String id) async {
    final response = await PostItemApiClient().fetchUserPostData(userProfile.id, 10, 0);
    return response.totalRecords;
  }
  Future<int> getNumberOfForums(String id) async {
    final response = await ForumListApiClient().fetchForums(userProfile.id);
    return response.length;
  }

  getNumberOfFriends(String id) async{

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

        newUserpostItemList.add(userpostItem);
      }
      return newUserpostItemList;

    } on Exception catch (e) {
      print(e);
      return [] ;
    }
  }





}

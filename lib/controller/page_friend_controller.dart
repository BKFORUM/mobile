import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/friends_api_client.dart';
import 'package:bkforum/data/apiClient/user_api_client.dart';
import 'package:bkforum/data/models/friend_model.dart';
import 'package:bkforum/data/models/user_model.dart';

const TYPE_NOT_FRIEND = "NOT FRIEND";
class PageFriendController extends GetxController {
  PageFriendController({required this.apiFriendClient, required this.apiUserClient});
  FriendsApiClient apiFriendClient;
  UserApiClient apiUserClient;
  final myFriends = <MyFriendModel>[].obs;
  final friendRequests = <MyFriendModel>[].obs;
  final friendSuggest = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyFriends();
    getFriendRequest();
    getUser();
  }
  @override
  void onClose(){
    super.onClose();
  }

  Future<void> getMyFriends () async {
    List<MyFriendModel> list = await apiFriendClient.getMyFriends();
    myFriends.assignAll(list);
  }

  Future<void> getFriendRequest () async {
    List<MyFriendModel> list = await apiFriendClient.getFriendRequests();
    friendRequests.assignAll(list);
  }

  Future<void> getUser() async {
    List<User> list = await apiUserClient.getUsers();
    for(User i in list) {
      if(i.friendStatus.toString() == TYPE_NOT_FRIEND) {
        print(i.friendStatus);
        friendSuggest.add(i);
      }
    }
  }
  
}
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/friends_api_client.dart';
import 'package:bkforum/data/models/friend_model.dart';

class PageFriendController extends GetxController {
  PageFriendController({required this.apiClient});
  FriendsApiClient apiClient;
  final myFriends = <MyFriendModel>[].obs;
  final friendRequests = <MyFriendModel>[].obs;
  final friendSuggest = <MyFriendModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyFriends();
    getFriendRequest();
  }
  @override
  void onClose(){
    super.onClose();
  }

  Future<void> getMyFriends () async {
    List<MyFriendModel> list = await apiClient.getMyFriends();
    myFriends.assignAll(list);
  }

  Future<void> getFriendRequest () async {
    List<MyFriendModel> list = await apiClient.getFriendRequests();
    friendRequests.assignAll(list);
  }
  
}
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/friends_api_client.dart';
import 'package:bkforum/data/apiClient/user_api_client.dart';
import 'package:bkforum/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TYPE_NOT_FRIEND = "NOT FRIEND";
const TYPE_PENDING_SEND = "PENDING_SENT";
const TYPE_PENDING_RECEIVE = "PENDING_RECEIVED";
const TYPE_ACTIVE = "ACTIVE";

class PageFriendController extends GetxController {
  FriendsApiClient apiFriendClient = FriendsApiClient();
  UserApiClient apiUserClient = UserApiClient();
  final myFriends = <User>[].obs;
  final friendRequests = <User>[].obs;
  final friendSuggest = <User>[].obs;
  String id = '';

  @override
  void onInit() async{
    super.onInit();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.id = preferences.getString('id') ?? '';
    getUser();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String> getUserId() async {
    final preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id') ?? '';
    return id;
  }

  Future<void> createFriendRequest(String id) async {
    await apiFriendClient.createFriendRequest(id);
    getUser();
  }

  Future<void> updateStatusFriendSuggest(String id, String status) async {
    await apiFriendClient.updateStatusFriend(id, status);
    await getUser();
  }

  Future<void> updateStatusFriendRequest(String id, String status) async {
    await apiFriendClient.updateStatusFriend(id, status);
    await getUser();
  }

  Future<void> updateStatusMyFriend(String id, String status) async {
    await apiFriendClient.updateStatusFriend(id, status);
    await getUser();
  }

  Future<void> getUser() async {
    List<User> list = await apiUserClient.getUsers();
    List<User> listFriendSuggest = <User>[].obs;
    List<User> listFriendRequest = <User>[].obs;
    List<User> listMyFriends = <User>[].obs;
    for (User i in list) {
      if (i.id.toString() == this.id){
        continue;
      }
      if ((i.friendStatus.toString() == TYPE_NOT_FRIEND ||
          i.friendStatus.toString() == TYPE_PENDING_SEND)) {
        listFriendSuggest.add(i);
      } else if (i.friendStatus.toString() == TYPE_PENDING_RECEIVE) {
        listFriendRequest.add(i);
      } else if (i.friendStatus.toString() == TYPE_ACTIVE) {
        listMyFriends.add(i);
      }
    }
    friendSuggest.assignAll(listFriendSuggest);
    friendRequests.assignAll(listFriendRequest);
    myFriends.assignAll(listMyFriends);
  }
}

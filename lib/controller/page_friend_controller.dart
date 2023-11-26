import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/friends_api_client.dart';
import 'package:bkforum/presentation/page_friends_screen/model/my_friend_model.dart';

class PageFriendController extends GetxController {
  PageFriendController({required this.apiClient});
  FriendsApiClient apiClient;
  final myFriends = <MyFriendModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyFriends();
  }
  @override
  void onClose(){
    super.onClose();
  }

  Future<void> getMyFriends () async {
    List<MyFriendModel> list = await apiClient.getFriendRequests();
    print("HELLLOOOOOO");
    myFriends.addAll(list);
  }
  
}
import 'package:bkforum/controller/page_friend_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/friends_api_client.dart';
import 'package:bkforum/data/apiClient/user_api_client.dart';

class PageMyFriendBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => PageFriendController(apiFriendClient: FriendsApiClient(), apiUserClient: UserApiClient()));
  }
}
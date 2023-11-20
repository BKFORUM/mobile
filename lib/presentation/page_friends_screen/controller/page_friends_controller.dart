import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/apiClient/get_my_friends.dart';
import 'package:bkforum/presentation/page_friends_screen/model/friends_request_model.dart';
import 'package:bkforum/presentation/page_friends_screen/model/my_friend_model.dart';

class PageFriendsController extends GetxController {
  Rx<FriendsRequestModel> pageFriendsRequestModelObj = FriendsRequestModel().obs;
  Rx<List<MyFriendModel>> myFriendsObjs = Rx(List.generate(4, (index) => MyFriendModel()));

  void FetchMyFriends() async {
    try {
      List<MyFriendModel> myFriends = await GetMyFriendsApiClient().fetchData();
    } catch (error) {
      print('Error fetching comments: $error');
    }
  }
}

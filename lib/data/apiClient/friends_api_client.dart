import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/core/utils/RxString.dart';
import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:bkforum/presentation/page_friends_screen/model/my_friend_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsApiClient extends GetConnect {
  Future<dynamic> getMyFriends() async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.myFriends,
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<MyFriendModel> myFriends = [];
      for (dynamic data in response.body) {
        myFriends.add(mapResponseToObj(data));
      }
      return myFriends;
    } else {
      final code = response.statusCode;
      final detail = response.statusText;
      throw Exception('Failed to fetch data, status code $code, error $detail');
    }
  }

  Future<dynamic> getFriendRequests() async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.friendRequests,
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<MyFriendModel> myFriends = [];
      for (dynamic data in response.body) {
        myFriends.add(mapResponseToObj(data['sender']));
      }
      return myFriends;
    } else {
      final code = response.statusCode;
      throw Exception('Failed to fetch data, status code $code');
    }
  }

  MyFriendModel mapResponseToObj(dynamic data) {
    MyFriendModel myfriend = MyFriendModel(
      id: PointerToRx(data['id']),
      avatarUrl: PointerToRx(data['avatarUrl']),
      dateOfBirth: PointerToRx(data['dateOfBirth']),
      email: PointerToRx(data['email']),
      fullName: PointerToRx(data['fullName']),
      gender: PointerToRx(data['gender']),
      phoneNumber: PointerToRx(data['phoneNumber']),
      address: PointerToRx(data['address']),
    );
    return myfriend;
  }
}

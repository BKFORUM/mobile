import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/core/utils/RxString.dart';
import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:bkforum/data/models/friend_model.dart';
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

  Future<void> createFriendRequest(String id) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await post(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.friendRequests,
      {
        "id": id
      },
      headers: headers,
    );

    if (response.statusCode! >= 400){
      final code = response.statusCode;
      throw Exception('Failed to create a friend request, status code $code');
    }
  }

  Future<void> updateStatusFriend(String id, String status) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await patch(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.friendRequests + '/$id',
      {
        "status": status
      },
      headers: headers,
    );

    if (response.statusCode! >= 400){
      final code = response.statusCode;
      throw Exception('Failed to update a friend request, status code $code');
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

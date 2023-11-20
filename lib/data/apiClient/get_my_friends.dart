import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:bkforum/presentation/page_friends_screen/model/my_friend_model.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GetMyFriendsApiClient extends GetConnect {
  Future<dynamic> fetchData() async {
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImZkMWUwOTE1LTMzOWItNDE3ZS04MDgzLWM3OWI4MjdjM2Q0MCIsInNlc3Npb24iOiIkMmIkMTAkSmNXdzdrZ1kzdGlBUXRDcVZhUWVLT2VCTUtNZlcyR28uV3diLkdiLk1TSDhNSFdMZTlEWXEiLCJlbWFpbCI6IjEwMjIwMDM3MkBzdjEuZHV0LnVkbi52biIsImZ1bGxOYW1lIjoiVHLhuqduIFRo4buLIERp4buFbSIsInJvbGVzIjpbIlVTRVIiXSwiaWF0IjoxNzAwNDc4MDAwLCJleHAiOjE3MDA0ODUyMDB9.vfrJ9Cvb7WphHO3jTwEveraf5Qzv5sAn0xZFyd2gox8";
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.myFriends,
      headers: headers,

    );
    print("data: ");
    print(response.body['data'].length);
    if (response.statusCode == 200) {
      List<MyFriendModel> myFriends = [];
      for(dynamic data in response.body['data']) {
        print("data: ");
        print(data);
        final myFriend = MyFriendModel(
          id: Rx<String>(data['id'])
        );
        myFriends.add(myFriend);
      }
      return myFriends;
    } else {
      final code = response.statusCode;
      throw Exception('Failed to fetch data, status code $code');
    }
  }
}
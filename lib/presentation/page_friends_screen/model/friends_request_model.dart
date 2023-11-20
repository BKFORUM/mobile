import 'package:bkforum/core/app_export.dart';

class  FriendsRequestModel{
  Rx<List<FriendRequest>> friendsRequest = 
    Rx(List.generate(4, (index) => FriendRequest()));
}

class FriendRequest {
  FriendRequest({this.id}){
    id = id ?? Rx("");
  }

  Rx<String>? id;
}
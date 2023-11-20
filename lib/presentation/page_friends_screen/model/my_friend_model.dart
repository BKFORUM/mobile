import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyFriendModel {
  MyFriendModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.avartarUrl,
    this.dateOfBirth,
    this.email,
    this.gender
  }){
    id = id ?? Rx("0");
    fullName = fullName ?? Rx("...");
    phoneNumber = phoneNumber ?? Rx("...");
    address = address ?? Rx("...");
    avartarUrl = avartarUrl ?? Rx("https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png");
    dateOfBirth = dateOfBirth ?? Rx("2024-02-14T00:00:00.000Z");
    email = email ?? Rx("...");
    gender = gender ?? Rx("MALE");
  }

  Rx<String>? id;
  Rx<String>? fullName;
  Rx<String>? phoneNumber;
  Rx<String>? address;
  Rx<String>? avartarUrl;
  Rx<String>? dateOfBirth;
  Rx<String>? email;
  Rx<String>? gender;
  
}
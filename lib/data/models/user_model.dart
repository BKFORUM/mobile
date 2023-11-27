import 'package:bkforum/core/utils/RxString.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class User {
  User({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.avatarUrl,
    this.dateOfBirth,
    this.email,
    this.gender,
    this.friendStatus,
    this.createdAt,
    this.updatedAt,
    this.facultyId,
    this.type,
  }){
    id = id ?? Rx("0");
    fullName = fullName ?? Rx("...");
    phoneNumber = phoneNumber ?? Rx("...");
    address = address ?? Rx("...");
    avatarUrl = avatarUrl ?? Rx("https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png");
    dateOfBirth = dateOfBirth ?? Rx("2024-02-14T00:00:00.000Z");
    email = email ?? Rx("...");
    gender = gender ?? Rx("MALE");
    friendStatus = friendStatus ?? Rx("ACTICE");
  }

  Rx<String>? id;
  Rx<String>? fullName;
  Rx<String>? phoneNumber;
  Rx<String>? address;
  Rx<String>? avatarUrl;
  Rx<String>? dateOfBirth;
  Rx<String>? email;
  Rx<String>? gender;
  Rx<String>? type;
  Rx<String>? facultyId;
  Rx<String>? createdAt;
  Rx<String>? updatedAt;
  Rx<String>? friendStatus;

  factory User.mapResponseToObj(dynamic data) {
    User user = User(
      id: PointerToRx(data['id']),
      avatarUrl: PointerToRx(data['avatarUrl']),
      dateOfBirth: PointerToRx(data['dateOfBirth']),
      email: PointerToRx(data['email']),
      fullName: PointerToRx(data['fullName']),
      gender: PointerToRx(data['gender']),
      phoneNumber: PointerToRx(data['phoneNumber']),
      address: PointerToRx(data['address']),
      type: PointerToRx(data['type']),
      facultyId: PointerToRx(data['facultyId']),
      createdAt: PointerToRx(data['createdAt']),
      updatedAt: PointerToRx(data['updatedAt']),
      friendStatus: PointerToRx(data['friendStatus']),
    );
    return user;
  }
}
import 'package:bkforum/data/models/role_model.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';
import 'faculty_model.dart';

class Profile {
  String id;
  String fullName;
  DateTime? dateOfBirth;
  String? email;
  String? address;
  String? phoneNumber;
  String? gender;
  String? type;
  Faculty? faculty;
  List<Forum>? forums;
  String? avatarUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Role>? roles;
  String? friendStatus;

  Profile({
    required this.id,
    required this.fullName,
    this.dateOfBirth,
    this.email,
    this.address,
    this.phoneNumber,
    this.gender,
    this.type,
    this.faculty,
    this.forums,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
    this.roles,
    this.friendStatus
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      fullName: json['fullName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      email: json['email'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      type: json['type'],
      faculty: Faculty.fromJson(json['faculty']),
      forums: List<Forum>.from(json['forums'].map((x) => Forum.fromJson(x))),
      avatarUrl: json['avatarUrl'] ?? 'defaultURL',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      roles: List<Role>.from(json['roles'].map((x) => Role.fromJson(x))),
      friendStatus: json['friendStatus'],
    );
  }
}


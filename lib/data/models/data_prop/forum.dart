import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/users.dart';

import '../profile_model.dart';
import '../topic.dart';

class Forum {
  String id;
  String name;
  String? modId;
  String modName;
  String? avatarUrl;
  String? type;
  List<Topic>? topics;
  List<User>? users;
  String? yourStatus;

  Forum(
      {required this.id,
      required this.name,
      this.modId,
      required this.modName,
      this.avatarUrl,
      this.type,
      this.topics,
      this.users,
      this.yourStatus});

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
        id: json['id'] ?? 'Default id',
        name: json['name'] ?? 'Default name',
        modId: json['modId'] ?? 'Default modId',
        modName: 'Một người nào đó',
        avatarUrl: json['avatarUrl'] ?? 'https://bom.so/put5aG',
        type: json['type'] ?? 'type',
        topics: (json['topics'] as List<dynamic>?)
            ?.map((topicJson) => Topic.fromJson(topicJson))
            .toList(),
        users: (json['users'] as List<dynamic>?)
            ?.map((userJson) => User(
            id: userJson['user']['id'],
            fullName: userJson['user']['fullName'],
            avatarUrl: userJson['user']['avatarUrl']
        ))
            .toList(),
        yourStatus: json['yourStatus']);
  }
}

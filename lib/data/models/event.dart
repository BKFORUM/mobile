import 'package:bkforum/data/models/data_prop/document.dart';
import '../../core/app_export.dart';
import 'data_prop/post_count.dart';
import 'data_prop/users.dart';

class Event {
  Rx<String>? id;
  Rx<DateTime>? createdAt;
  Rx<DateTime>? updatedAt;
  Rx<String>? forumId;
  Rx<String>? userId;
  Rx<String>? displayName;
  Rx<String>? location;
  Rx<DateTime>? startAt;
  Rx<DateTime>? endAt;
  Rx<String>? status;
  Rx<String>? type;
  Rx<String>? content;
  RxList<User>? users;
  RxList<PostDocument>? documents;
  Rx<Count>? count;
  Rx<bool>? isSubscriber;

  Event({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.forumId,
    this.userId,
    this.displayName,
    this.location,
    this.startAt,
    this.endAt,
    this.status,
    this.type,
    this.content,
    this.users,
    this.documents,
    this.count,
    this.isSubscriber,
  });
}
  // factory Event.fromJson(Map<String, dynamic> json) {
  //   var usersList = json['users'] as List;
  //   List<User> users = usersList.map((user) => User.fromJson(user)).toList();
  //
  //   var documentsList = json['documents'] as List;
  //   List<PostDocument> documents =
  //   documentsList.map((document) => PostDocument.fromJson(document)).toList();
  //
  //   return Event(
  //     id: json['id'] ?? '',
  //     createdAt: DateTime.parse(json['createdAt']),
  //     updatedAt: DateTime.parse(json['updatedAt']),
  //     forumId: json['forumId'] ?? '',
  //     userId: json['userId'] ?? '',
  //     displayName: json['displayName'] ?? '',
  //     location: json['location'] ?? '',
  //     startAt: DateTime.parse(json['startAt']),
  //     endAt: DateTime.parse(json['endAt']),
  //     status: json['status'] ?? '',
  //     type: json['type'] ?? '',
  //     content: json['content'] ?? '',
  //     users: users,
  //     documents: documents,
  //     count: Count.fromJson(json['_count']),
  //     isSubscriber: json['isSubscriber'],
  //   );
  // }






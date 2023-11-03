import 'package:bkforum/presentation/page_feed_screen/models/data_prop/post_count.dart';
import 'package:bkforum/presentation/page_feed_screen/models/data_prop/users.dart';
import 'package:bkforum/presentation/page_feed_screen/models/data_prop/forum.dart';
import 'package:bkforum/presentation/page_feed_screen/models/data_prop/document.dart';

class Data {
  String id;
  Forum forum;
  String content;
  User user;
  List<PostDocument> documents;
  String status;
  DateTime createdAt;
  Count count;

  Data({required this.id, required this.forum, required this.content,
    required this.user,required this.documents,required this.status,
    required this.createdAt,required this.count});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      forum: Forum.fromJson(json['forum']),
      content: json['content'],
      user: User.fromJson(json['user']),
      documents: List<PostDocument>.from(json['documents'].map((x) => PostDocument.fromJson(x))),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      count: Count.fromJson(json['_count']),
    );
  }
}
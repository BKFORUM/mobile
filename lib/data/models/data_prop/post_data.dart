import 'package:bkforum/data/models/data_prop/post_count.dart';
import 'package:bkforum/data/models/data_prop/users.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';
import 'package:bkforum/data/models/data_prop/document.dart';

class Data {
  String id;
  Forum forum;
  String content;
  User? user;
  List<PostDocument>? documents;
  String status;
  DateTime createdAt;
  Count? count;
  DateTime? likedAt;

  Data(
      {required this.id,
      required this.forum,
      required this.content,
      this.user,
      this.documents,
      required this.status,
      required this.createdAt,
      this.count,
      this.likedAt});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] ?? 'Default',
      forum: Forum.fromJson(json['forum']),
      content: json['content'] ?? 'Default',
      user: User.fromJson(json['user']),
      documents: List<PostDocument>.from(
          json['documents'].map((x) => PostDocument.fromJson(x))),
      status: json['status'] ?? 'Default',
      createdAt: DateTime.parse(json['createdAt'] ?? 'Default'),
      count: Count.fromJson(json['_count']),
      likedAt: json['likedAt'] != null
          ? DateTime.parse(json['likedAt'])
          : DateTime(2012, 1, 1),
    );
  }
}

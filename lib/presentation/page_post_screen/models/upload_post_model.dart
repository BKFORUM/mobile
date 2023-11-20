import 'package:bkforum/presentation/page_feed_screen/models/data_prop/document.dart';

class UploadPostModel{
  String forumId;
  String content;
  List<PostDocument>? document;

  UploadPostModel({
    required this.forumId,
    required this.content,
    this.document
  });

  Map<String, dynamic> toJson() => {
    'forumId': forumId,
    'content': content,
    'documents': document?.map((doc) => doc.toJson()).toList(),
  };
}
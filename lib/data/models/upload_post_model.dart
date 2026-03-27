import 'package:bkforum/data/models/data_prop/document.dart';

class UploadPostModel{
  String? forumId;
  String? content;
  List<PostDocument>? document;

  UploadPostModel({
    this.forumId,
    this.content,
    this.document
  });

  Map<String, dynamic> toJson() => {
    'forumId': forumId,
    'content': content,
    'documents': document?.map((doc) => doc.toJson()).toList(),
  };

  void reset() {
    forumId = null;
    content = null;
    document = null;
  }
}
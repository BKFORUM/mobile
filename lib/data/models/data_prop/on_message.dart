import 'package:bkforum/data/models/data_prop/message.dart';

class OnMessage {
  String? id;
  String? content;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? conversationId;
  Author? author;

  OnMessage({
    this.id,
    this.content,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.conversationId,
    this.author,
  });

  factory OnMessage.fromJson(Map<String, dynamic> json) {
    return OnMessage(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      conversationId: json['conversationId'] ?? '',
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
    );
  }
}


import 'package:bkforum/data/models/data_prop/users.dart';

class Notifications {
  String? content;
  DateTime? createdAt;
  String? id;
  String? modelId;
  String? modelName;
  DateTime? readAt;
  User? sender;
  String? senderId;
  DateTime? updatedAt;
  String? userId;

  Notifications({
    this.content,
    this.createdAt,
    this.id,
    this.modelId,
    this.modelName,
    this.readAt,
    this.sender,
    this.senderId,
    this.updatedAt,
    this.userId,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      content: json['content'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      id: json['id'] ?? '',
      modelId: json['modelId'] ?? '',
      modelName: json['modelName'] ?? '',
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
      sender: json['sender'] != null ? User.fromJson(json['sender']) : null,
      senderId: json['senderId'] ?? '',
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      userId: json['userId'] ?? '',
    );
  }
}

import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/users.dart';

class Conversation {
  String? avatarUrl;
  String? id;
  String? displayName;
  LastMessage? lastMessage;
  String? type;
  String? forumId;
  List<UserConversation>? users;
  bool isRead = false;

  Conversation({
    this.avatarUrl,
    this.id,
    this.displayName,
    this.lastMessage,
    this.type,
    this.forumId,
    this.users,
    required this.isRead,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      avatarUrl: json['avatarUrl'] ?? DEFAULT_URL_AVATAR_CONVERSATION,
      id: json['id'] ?? '',
      displayName: json['displayName'] ?? 'd',
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'])
          : null,
      type: json['type'] ?? '',
      forumId: json['forumId'] ?? '',
      users: (json['users'] as List<dynamic>?)
          ?.map((userJson) => UserConversation.fromJson(userJson))
          .toList(),
      isRead: json['isRead'],
    );
  }
}

class LastMessage {
  String? id;
  String? conversationId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  String? content;
  String? type;

  LastMessage(
      {this.id,
      this.conversationId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.content,
      this.type});

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['id'] ?? '',
      conversationId: json['conversationId'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      content: json['content'] ?? ' ',
      type: json['type'] ?? '',
    );
  }
}

class UserConversation {
  String? userId;
  String? displayName;
  User? user;

  UserConversation({this.userId, this.displayName, this.user});

  factory UserConversation.fromJson(Map<String, dynamic> json) {
    return UserConversation(
      userId: json['userId'] ?? '',
      displayName: json['displayName'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

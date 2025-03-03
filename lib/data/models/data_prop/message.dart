import 'package:bkforum/data/models/data_prop/on_message.dart';

class Message {
  String? id;
  String? content;
  String? type;
  String? createdAt;
  String? updatedAt;
  Author? author;

  Message({
    this.id,
    this.content,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.author,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
    );
  }

  factory Message.convertFromOnMessage(OnMessage msg){
    return Message(
      id: msg.id,
      author: msg.author,
      content: msg.content,
      createdAt: msg.createdAt,
      type: msg.type,
      updatedAt: msg.updatedAt
    );
  }
}

class Author {
  String? id;
  String? fullName;
  String? phoneNumber;
  String? address;
  String? avatarUrl;
  String? dateOfBirth;
  String? email;
  String? gender;
  String? displayName;

  Author(
      {this.id,
      this.fullName,
      this.phoneNumber,
      this.address,
      this.avatarUrl,
      this.dateOfBirth,
      this.email,
      this.gender,
      this.displayName});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      displayName: json['displayName'] ?? '',
    );
  }
}

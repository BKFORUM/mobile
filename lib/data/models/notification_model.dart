import 'package:get/get.dart';

class NotificationModel {
  Rx<String>? id;
  Rx<String>? content;
  Rx<String>? modelId;
  Rx<String>? modelName;
  Rx<String>? userId;
  Rx<String>? senderId;
  Rx<DateTime>? readAt;
  Rx<DateTime>? createdAt;
  Rx<DateTime>? updatedAt;
  Rx<Sender>? sender;

  NotificationModel({
    this.id,
    this.content,
    this.modelId ,
    this.modelName ,
    this.userId ,
    this.senderId ,
    this.readAt ,
    this.createdAt ,
    this.updatedAt ,
    this.sender,
  }) {
    id = id ?? Rx('');
    content = content ?? Rx('');
    modelId = modelId ?? Rx('');
    modelName = modelName ?? Rx('');
    userId = userId ?? Rx('');
    senderId = senderId ?? Rx('');
    readAt = readAt;
    createdAt = createdAt ?? Rx(DateTime.now());
    updatedAt = updatedAt ?? Rx(DateTime.now());
    sender = sender ?? Rx(Sender());
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      content: json['content'],
      modelId: json['modelId'],
      modelName: json['modelName'],
      userId: json['userId'],
      senderId: json['senderId'],
      readAt: json['readAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      sender: Rx<Sender>(Sender.fromJson(json['sender'])),
    );
  }
}

class Sender {
  Rx<String>? id;
  Rx<String>? fullName;
  Rx<String>? email;
  Rx<String>? dateOfBirth;
  Rx<String>? gender;
  Rx<String>? phoneNumber;
  Rx<String>? address;
  Rx<String>? avatarUrl;
  Sender({
    this.id,
    this.fullName,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.address,
    this.avatarUrl,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      avatarUrl: json['avatarUrl'] ?? 'https://bom.so/SjYyN2',
    );
  }
}
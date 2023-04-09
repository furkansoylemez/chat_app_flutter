import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });

  factory MessageModel.fromDocument(DocumentSnapshot doc) {
    return MessageModel(
      senderId: doc['senderId'] as String,
      receiverId: doc['receiverId'] as String,
      content: doc['content'] as String,
      timestamp: doc['timestamp'] as int,
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      content: map['content'] as String,
      timestamp: map['timestamp'] as int,
    );
  }

  String senderId;
  String receiverId;
  String content;
  int timestamp;
}

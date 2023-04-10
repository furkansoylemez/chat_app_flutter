import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  Conversation({
    required this.id,
    required this.otherUserId,
    required this.lastMessage,
    required this.timestamp,
  });
  factory Conversation.fromDocument(DocumentSnapshot doc) {
    final lastMessageData = doc['lastMessage'] as Map<String, dynamic>;

    return Conversation(
      id: doc.id,
      otherUserId: doc['otherUserId'] as String,
      lastMessage: LastMessage(
        content: lastMessageData['content'] as String,
        senderId: lastMessageData['senderId'] as String,
      ),
      timestamp: doc['timestamp'] as int,
    );
  }
  final String id;
  final String otherUserId;
  final LastMessage lastMessage;
  final int timestamp;
}

class LastMessage {
  LastMessage({required this.content, required this.senderId});
  final String content;
  final String senderId;
}

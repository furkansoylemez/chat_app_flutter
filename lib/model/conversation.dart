import 'package:birsu/core/helper/other_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  Conversation({
    required this.id,
    required this.otherUserId,
    required this.lastMessage,
    required this.timestamp,
  });
  factory Conversation.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final lastMessageData = data['lastMessage'] as Map<String, dynamic>;

    return Conversation(
      id: snapshot.id,
      otherUserId: data['otherUserId'] as String,
      lastMessage: Message(
        content: lastMessageData['content'] as String,
        senderId: lastMessageData['senderId'] as String,
      ),
      timestamp: getFormattedDate(data['timestamp'] as int),
    );
  }
  final String id;
  final String otherUserId;
  final Message lastMessage;
  final String timestamp;
}

class Message {
  Message({required this.content, required this.senderId});
  final String content;
  final String senderId;
}

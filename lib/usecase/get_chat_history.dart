import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_exception.dart';
import 'package:birsu/model/message.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_chat_history.g.dart';

@riverpod
GetChatHistory getChatHistory(GetChatHistoryRef ref) {
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  final appUserId = ref.watch(appUserProvider)?.uid ?? '';

  return GetChatHistory(
    firebaseFirestore: firebaseFirestore,
    appUserId: appUserId,
  );
}

class GetChatHistory {
  GetChatHistory({required this.firebaseFirestore, required this.appUserId});

  final FirebaseFirestore firebaseFirestore;
  final String appUserId;

  Future<List<Message>> action(String conversationId) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection(AppConstants.usersCollection)
          .doc(appUserId)
          .collection(AppConstants.conversationsCollection)
          .doc(conversationId)
          .collection(AppConstants.messagesCollection)
          .orderBy(AppConstants.timestampField, descending: false)
          .get();
      return querySnapshot.docs.map(Message.fromDocument).toList();
    } catch (error) {
      throw AppException(error.toString());
    }
  }
}

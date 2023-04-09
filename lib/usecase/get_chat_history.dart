import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_exception.dart';
import 'package:birsu/model/message_model.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_chat_history.g.dart';

@riverpod
class GetChatHistory extends _$GetChatHistory {
  @override
  void build() {}

  Future<List<MessageModel>> action(String conversationId) async {
    try {
      final firebaseFirestore = ref.read(firebaseFirestoreProvider);
      final appUser = ref.read(appUserProvider);
      final querySnapshot = await firebaseFirestore
          .collection(AppConstants.usersCollection)
          .doc(appUser?.uid)
          .collection(AppConstants.conversationsCollection)
          .doc(conversationId)
          .collection(AppConstants.messagesCollection)
          .orderBy(AppConstants.timestampField, descending: false)
          .get();
      return querySnapshot.docs.map(MessageModel.fromDocument).toList();
    } catch (error) {
      throw AppException(error.toString());
    }
  }
}

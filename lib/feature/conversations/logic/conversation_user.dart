import 'package:birsu/core/app_constants.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_user.g.dart';

@riverpod
Stream<DocumentSnapshot> conversationUser(
  ConversationUserRef ref,
  String otherUserId,
) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore
      .collection(AppConstants.usersCollection)
      .doc(otherUserId)
      .snapshots();
}

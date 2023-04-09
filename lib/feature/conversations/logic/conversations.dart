import 'package:birsu/core/app_constants.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations.g.dart';

@riverpod
Stream<QuerySnapshot> conversations(
  ConversationsRef ref,
) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final appUser = ref.watch(appUserProvider);
  return firestore
      .collection(AppConstants.usersCollection)
      .doc(appUser?.uid)
      .collection(AppConstants.conversationsCollection)
      .snapshots();
}

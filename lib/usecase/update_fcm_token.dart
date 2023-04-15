import 'package:birsu/provider/app_user.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_fcm_token.g.dart';

@riverpod
UpdateFcmToken updateFcmToken(UpdateFcmTokenRef ref) {
  final appUserId =
      ref.watch(appUserProvider.select((value) => value?.uid ?? ''));
  return UpdateFcmToken(
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
    appUserId: appUserId,
  );
}

class UpdateFcmToken {
  UpdateFcmToken({
    required this.firebaseFirestore,
    required this.appUserId,
  });
  final FirebaseFirestore firebaseFirestore;
  final String appUserId;
  Future<void> action() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();

      await firebaseFirestore
          .collection('users')
          .doc(appUserId)
          .set({'fcmToken': fcmToken}, SetOptions(merge: true));
    } catch (error) {
      print(error.toString());
    }
  }
}

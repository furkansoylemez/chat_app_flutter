import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_exception.dart';
import 'package:birsu/model/app_user.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_users.g.dart';

@riverpod
GetUsers getUsers(GetUsersRef ref) {
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  return GetUsers(firebaseFirestore: firebaseFirestore);
}

class GetUsers {
  GetUsers({required this.firebaseFirestore});

  final FirebaseFirestore firebaseFirestore;

  Future<List<AppUser>> action() async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection(AppConstants.usersCollection)
          .get();
      return querySnapshot.docs.map(AppUser.fromDocument).toList();
    } catch (error) {
      throw AppException(error.toString());
    }
  }
}

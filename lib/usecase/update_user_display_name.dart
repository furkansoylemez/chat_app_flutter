import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_exception.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_user_display_name.g.dart';

@riverpod
class UpdateUserDisplayName extends _$UpdateUserDisplayName {
  @override
  void build() {}

  Future<bool> action(User user, String displayName) async {
    final firebaseFirestore = ref.read(firebaseFirestoreProvider);
    try {
      final usersCollection =
          firebaseFirestore.collection(AppConstants.usersCollection);
      await user.updateDisplayName(displayName);
      await usersCollection.doc(user.uid).set(
        {
          'uid': user.uid,
          'name': displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
        },
      );
      return true;
    } catch (error) {
      throw AppException(error.toString());
    }
  }
}

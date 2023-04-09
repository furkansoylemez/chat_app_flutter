import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_exception.dart';
import 'package:birsu/provider/firebase_auth.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:birsu/provider/localizations_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_user.g.dart';

@riverpod
class CreateUser extends _$CreateUser {
  @override
  void build() {}

  Future<bool> action(
    String displayName,
    String emailAddress,
    String password,
  ) async {
    final firebaseAuth = ref.read(firebaseAuthProvider);

    final firebaseFirestore = ref.read(firebaseFirestoreProvider);
    final usersCollection =
        firebaseFirestore.collection(AppConstants.usersCollection);

    final loc = ref.read(localizationsProvider);
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (userCredential.user != null) {
        final user = userCredential.user;
        await userCredential.user?.updateDisplayName(displayName);
        await usersCollection.doc(user?.uid).set(
          {
            'uid': user?.uid,
            'name': displayName,
            'email': user?.email,
            'photoUrl': user?.photoURL,
          },
        );
      }

      return true;
    } catch (error) {
      String errorMessage;
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'weak-password':
            errorMessage = loc.weakPasswordError;
            break;
          case 'email-already-in-use':
            errorMessage = loc.emailAlreadyInUseError;
            break;
          case 'invalid-email':
            errorMessage = loc.invalidEmailError;
            break;
          default:
            errorMessage = error.toString();
        }
      } else {
        errorMessage = error.toString();
      }
      throw AppException(errorMessage);
    }
  }
}

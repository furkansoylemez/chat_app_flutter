import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_exception.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/provider/firebase_auth.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:birsu/provider/localizations_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_user.g.dart';

@riverpod
CreateUser createUser(CreateUserRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  final loc = ref.watch(localizationsProvider);
  return CreateUser(
    firebaseAuth: firebaseAuth,
    firebaseFirestore: firebaseFirestore,
    loc: loc,
  );
}

class CreateUser {
  CreateUser({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.loc,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final AppLocalizations loc;

  Future<bool> action(
    String displayName,
    String emailAddress,
    String password,
  ) async {
    final usersCollection =
        firebaseFirestore.collection(AppConstants.usersCollection);

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

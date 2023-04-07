import 'package:birsu/provider/firebase_auth_provider.dart';
import 'package:birsu/provider/localizations_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_user.g.dart';

@riverpod
class CreateUser extends _$CreateUser {
  @override
  void build() {}

  Future<UserCredential> action(String emailAddress, String password) async {
    final firebaseAuth = ref.read(firebaseAuthProvider);
    final loc = ref.read(localizationsProvider);
    return firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    )
        .onError((error, stackTrace) {
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
      throw Exception(errorMessage);
    });
  }
}

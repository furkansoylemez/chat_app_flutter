import 'package:birsu/core/app_exception.dart';
import 'package:birsu/provider/firebase_auth.dart';
import 'package:birsu/provider/localizations_provider.dart';
import 'package:birsu/usecase/core/core_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in.g.dart';

@riverpod
class SignIn extends _$SignIn {
  @override
  void build() {}

  Future<UserCredential> action(String emailAddress, String password) async {
    final firebaseAuth = ref.read(firebaseAuthProvider);
    final loc = ref.read(localizationsProvider);
    return futureHandler(
        firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress,
          password: password,
        ), (error) {
      String errorMessage;
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'invalid-email':
            errorMessage = loc.invalidEmailError;
            break;
          case 'user-disabled':
            errorMessage = loc.userDisabledError;
            break;
          case 'user-not-found':
            errorMessage = loc.userNotFoundError;
            break;
          case 'wrong-password':
            errorMessage = loc.wrongPasswordError;
            break;
          default:
            errorMessage = error.toString();
        }
      } else {
        errorMessage = error.toString();
      }

      throw AppException(errorMessage);
    });
  }
}

import 'package:birsu/core/app_exception.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/provider/firebase_auth.dart';
import 'package:birsu/provider/localizations_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in.g.dart';

@riverpod
SignIn signIn(SignInRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final loc = ref.watch(localizationsProvider);
  return SignIn(firebaseAuth: firebaseAuth, loc: loc);
}

class SignIn {
  SignIn({required this.firebaseAuth, required this.loc});

  final FirebaseAuth firebaseAuth;
  final AppLocalizations loc;

  Future<void> action(String emailAddress, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } catch (error) {
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
            errorMessage = error.message.toString();
        }
      } else {
        errorMessage = error.toString();
      }

      throw AppException(errorMessage);
    }
  }
}

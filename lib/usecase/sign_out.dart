import 'package:birsu/core/app_exception.dart';
import 'package:birsu/provider/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out.g.dart';

@riverpod
SignOut signOut(SignOutRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return SignOut(firebaseAuth: firebaseAuth);
}

class SignOut {
  SignOut({required this.firebaseAuth});

  final FirebaseAuth firebaseAuth;

  Future<void> action() async {
    try {
      return await firebaseAuth.signOut();
    } catch (error) {
      throw AppException(error.toString());
    }
  }
}

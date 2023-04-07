import 'package:birsu/provider/firebase_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user_provider.g.dart';

@riverpod
class AppUser extends _$AppUser {
  @override
  User? build() {
    _listenUserStream();
    return _fetchUser();
  }

  User? _fetchUser() {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final user = firebaseAuth.currentUser;
    return user;
  }

  void _listenUserStream() {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        state = user;
      } else {
        state = null;
      }
    });
  }
}

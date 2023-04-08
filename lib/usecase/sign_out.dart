import 'package:birsu/core/app_exception.dart';
import 'package:birsu/provider/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out.g.dart';

@riverpod
class SignOut extends _$SignOut {
  @override
  void build() {}

  Future<void> action() async {
    final firebaseAuth = ref.read(firebaseAuthProvider);

    try {
      return await firebaseAuth.signOut();
    } catch (error) {
      throw AppException(error.toString());
    }
  }
}

import 'package:birsu/provider/user_changes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user.g.dart';

@riverpod
User? appUser(AppUserRef ref) {
  final userChanges = ref.watch(userChangesProvider);
  final user = userChanges.asData?.value;
  if (user != null) {
    return user;
  } else {
    return null;
  }
}

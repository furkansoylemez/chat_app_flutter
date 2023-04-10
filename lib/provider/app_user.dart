import 'package:birsu/model/app_user.dart';
import 'package:birsu/provider/user_changes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user.g.dart';

@riverpod
AppUser? appUser(AppUserRef ref) {
  final user = ref.watch(userChangesProvider).value;
  if (user != null) {
    return AppUser.fromFirebaseUser(user);
  } else {
    return null;
  }
}

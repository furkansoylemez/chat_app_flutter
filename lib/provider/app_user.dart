import 'package:birsu/model/user_model.dart';
import 'package:birsu/provider/user_changes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user.g.dart';

@riverpod
UserModel? appUser(AppUserRef ref) {
  final userChanges = ref.watch(userChangesProvider);
  final user = userChanges.asData?.value;
  if (user != null) {
    final appUser = UserModel.fromFirebaseUser(user);
    return appUser;
  } else {
    return null;
  }
}

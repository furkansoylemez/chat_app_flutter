import 'package:birsu/core/app_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_user_display_name.g.dart';

@riverpod
class UpdateUserDisplayName extends _$UpdateUserDisplayName {
  @override
  void build() {}

  Future<bool> action(User user, String displayName) async {
    try {
      await user.updateDisplayName(displayName);
      return true;
    } catch (error) {
      throw AppException(error.toString());
    }
  }
}

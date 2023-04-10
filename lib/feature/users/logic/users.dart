import 'package:birsu/model/app_user.dart';
import 'package:birsu/provider/firebase_auth.dart';
import 'package:birsu/usecase/get_users.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users.g.dart';

@riverpod
class Users extends _$Users {
  @override
  FutureOr<List<AppUser>> build() async {
    return _fetchUsers();
  }

  Future<List<AppUser>> _fetchUsers() async {
    final getUsers = ref.watch(getUsersProvider);
    final users = await getUsers.action();
    final usersWithoutSignedInUser = users
        .where(
          (user) =>
              user.uid != ref.watch(firebaseAuthProvider).currentUser!.uid,
        )
        .toList();

    return usersWithoutSignedInUser;
  }

  Future<void> retryFetchUsers() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchUsers);
  }
}

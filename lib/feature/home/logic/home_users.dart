import 'package:birsu/model/user_model.dart';
import 'package:birsu/provider/firebase_auth.dart';
import 'package:birsu/usecase/get_users.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_users.g.dart';

@riverpod
class HomeUsers extends _$HomeUsers {
  @override
  FutureOr<List<UserModel>> build() async {
    return _fetchUsers();
  }

  Future<List<UserModel>> _fetchUsers() async {
    final getUsers = ref.watch(getUsersProvider.notifier);
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

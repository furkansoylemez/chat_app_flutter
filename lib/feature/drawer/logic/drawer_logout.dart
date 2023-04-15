import 'package:birsu/usecase/sign_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drawer_logout.g.dart';

@riverpod
class DrawerLogout extends _$DrawerLogout {
  @override
  Future<void> build() async {}

  Future<void> logout() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(ref.read(signOutProvider).action);
  }
}

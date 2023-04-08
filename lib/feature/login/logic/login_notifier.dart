import 'package:birsu/feature/login/logic/login_state.dart';
import 'package:birsu/usecase/sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() {
    return const LoginState(
      email: '',
      password: '',
      loginStatus: AsyncValue.data(null),
    );
  }

  void emailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void passwordChanged(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> login() async {
    state = state.copyWith(loginStatus: const AsyncValue.loading());
    state = state.copyWith(
      loginStatus: await AsyncValue.guard(() {
        return ref
            .read(signInProvider.notifier)
            .action(state.email, state.password);
      }),
    );
  }
}

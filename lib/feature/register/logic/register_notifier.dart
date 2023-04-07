import 'package:birsu/feature/register/logic/register_state.dart';
import 'package:birsu/usecase/register/create_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return const RegisterState(
      email: '',
      password: '',
      confirmPassword: '',
      registerStatus: AsyncValue.data(null),
    );
  }

  void emailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void passwordChanged(String password) {
    state = state.copyWith(password: password);
  }

  void confirmPasswordChanged(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  Future<void> register() async {
    state = state.copyWith(registerStatus: const AsyncValue.loading());
    state = state.copyWith(
      registerStatus: await AsyncValue.guard(() {
        return ref
            .read(createUserProvider.notifier)
            .action(state.email, state.password);
      }),
    );
  }
}

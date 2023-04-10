import 'package:birsu/feature/register/logic/register_state.dart';
import 'package:birsu/usecase/create_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return const RegisterState(
      displayName: '',
      email: '',
      password: '',
      confirmPassword: '',
      registerStatus: AsyncValue.data(false),
    );
  }

  void displayNameChanged(String displayName) {
    state = state.copyWith(displayName: displayName);
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
      registerStatus: await AsyncValue.guard(() async {
        await ref
            .read(createUserProvider)
            .action(state.displayName, state.email, state.password);
        return true;
      }),
    );
  }
}

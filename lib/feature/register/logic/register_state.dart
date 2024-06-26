import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    required String displayName,
    required String email,
    required String password,
    required String confirmPassword,
    required AsyncValue<bool> registerStatus,
  }) = _RegisterState;
}

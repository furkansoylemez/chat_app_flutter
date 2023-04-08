// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegisterState {
  String get displayName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get confirmPassword => throw _privateConstructorUsedError;
  AsyncValue<UserCredential?> get registerStatus =>
      throw _privateConstructorUsedError;
  AsyncValue<bool?> get updateDisplayNameStatus =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterStateCopyWith<RegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res, RegisterState>;
  @useResult
  $Res call(
      {String displayName,
      String email,
      String password,
      String confirmPassword,
      AsyncValue<UserCredential?> registerStatus,
      AsyncValue<bool?> updateDisplayNameStatus});
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res, $Val extends RegisterState>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? registerStatus = null,
    Object? updateDisplayNameStatus = null,
  }) {
    return _then(_value.copyWith(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      registerStatus: null == registerStatus
          ? _value.registerStatus
          : registerStatus // ignore: cast_nullable_to_non_nullable
              as AsyncValue<UserCredential?>,
      updateDisplayNameStatus: null == updateDisplayNameStatus
          ? _value.updateDisplayNameStatus
          : updateDisplayNameStatus // ignore: cast_nullable_to_non_nullable
              as AsyncValue<bool?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegisterStateCopyWith<$Res>
    implements $RegisterStateCopyWith<$Res> {
  factory _$$_RegisterStateCopyWith(
          _$_RegisterState value, $Res Function(_$_RegisterState) then) =
      __$$_RegisterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String displayName,
      String email,
      String password,
      String confirmPassword,
      AsyncValue<UserCredential?> registerStatus,
      AsyncValue<bool?> updateDisplayNameStatus});
}

/// @nodoc
class __$$_RegisterStateCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$_RegisterState>
    implements _$$_RegisterStateCopyWith<$Res> {
  __$$_RegisterStateCopyWithImpl(
      _$_RegisterState _value, $Res Function(_$_RegisterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? registerStatus = null,
    Object? updateDisplayNameStatus = null,
  }) {
    return _then(_$_RegisterState(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      registerStatus: null == registerStatus
          ? _value.registerStatus
          : registerStatus // ignore: cast_nullable_to_non_nullable
              as AsyncValue<UserCredential?>,
      updateDisplayNameStatus: null == updateDisplayNameStatus
          ? _value.updateDisplayNameStatus
          : updateDisplayNameStatus // ignore: cast_nullable_to_non_nullable
              as AsyncValue<bool?>,
    ));
  }
}

/// @nodoc

class _$_RegisterState implements _RegisterState {
  const _$_RegisterState(
      {required this.displayName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.registerStatus,
      required this.updateDisplayNameStatus});

  @override
  final String displayName;
  @override
  final String email;
  @override
  final String password;
  @override
  final String confirmPassword;
  @override
  final AsyncValue<UserCredential?> registerStatus;
  @override
  final AsyncValue<bool?> updateDisplayNameStatus;

  @override
  String toString() {
    return 'RegisterState(displayName: $displayName, email: $email, password: $password, confirmPassword: $confirmPassword, registerStatus: $registerStatus, updateDisplayNameStatus: $updateDisplayNameStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterState &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.registerStatus, registerStatus) ||
                other.registerStatus == registerStatus) &&
            (identical(
                    other.updateDisplayNameStatus, updateDisplayNameStatus) ||
                other.updateDisplayNameStatus == updateDisplayNameStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayName, email, password,
      confirmPassword, registerStatus, updateDisplayNameStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterStateCopyWith<_$_RegisterState> get copyWith =>
      __$$_RegisterStateCopyWithImpl<_$_RegisterState>(this, _$identity);
}

abstract class _RegisterState implements RegisterState {
  const factory _RegisterState(
          {required final String displayName,
          required final String email,
          required final String password,
          required final String confirmPassword,
          required final AsyncValue<UserCredential?> registerStatus,
          required final AsyncValue<bool?> updateDisplayNameStatus}) =
      _$_RegisterState;

  @override
  String get displayName;
  @override
  String get email;
  @override
  String get password;
  @override
  String get confirmPassword;
  @override
  AsyncValue<UserCredential?> get registerStatus;
  @override
  AsyncValue<bool?> get updateDisplayNameStatus;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterStateCopyWith<_$_RegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}

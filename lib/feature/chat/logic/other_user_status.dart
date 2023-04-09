import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'other_user_status.g.dart';

enum OtherUserStatusType {
  online,
  offline,
  typing,
}

@riverpod
class OtherUserStatus extends _$OtherUserStatus {
  @override
  OtherUserStatusType? build() {
    return null;
  }

  void setOnline() {
    state = OtherUserStatusType.online;
  }

  void setOffline() {
    state = OtherUserStatusType.offline;
  }

  void setTyping() {
    state = OtherUserStatusType.typing;
  }
}

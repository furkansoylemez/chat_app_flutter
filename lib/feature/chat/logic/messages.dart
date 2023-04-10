import 'package:birsu/model/message_model.dart';
import 'package:birsu/usecase/get_chat_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages.g.dart';

@riverpod
class Messages extends _$Messages {
  @override
  AsyncValue<List<MessageModel>> build() {
    return const AsyncValue.data([]);
  }

  Future<void> fetchMessageHistory(String conversationId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(getChatHistoryProvider).action(conversationId);
    });
  }

  void addMessage(MessageModel message) {
    if (state.value != null) {
      state = AsyncData([...state.value!, message]);
    }
  }
}

import 'package:birsu/core/app_constants.dart';
import 'package:birsu/feature/chat/logic/messages.dart';
import 'package:birsu/feature/chat/logic/other_user_status.dart';
import 'package:birsu/model/message.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'chat_socket.g.dart';

@riverpod
class ChatSocket extends _$ChatSocket {
  @override
  Socket build() {
    final socket = io(
      AppConstants.localSocketUrl,
      OptionBuilder()
          .setTransports([AppConstants.socketTransport])
          .disableAutoConnect()
          .build(),
    )
      ..onConnect((_) {
        debugPrint('Socket connected.');
      })
      ..onConnectError((data) {
        debugPrint('Socket connect error: $data');
      })
      ..connect()
      ..emit(AppConstants.userOnlineEvent, ref.read(appUserProvider)?.uid);

    ref.onDispose(() {
      socket
        ..emit(
          AppConstants.userOfflineEvent,
          ref.read(appUserProvider)?.uid,
        )
        ..disconnect()
        ..dispose();
    });

    return socket;
  }

  void sendMessage(String message, String receiverId) {
    final appUser = ref.watch(appUserProvider);
    final trimmedMessage = message.trim();
    if (trimmedMessage.isNotEmpty) {
      final messageData = {
        'senderId': appUser?.uid,
        'receiverId': receiverId,
        'content': trimmedMessage,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      state.emit(AppConstants.sendMessageEvent, messageData);
      ref
          .read(messagesProvider.notifier)
          .addMessage(Message.fromMap(messageData));
    }
  }

  void setSocketUserStatusEvents(String otherUserId) {
    state
      ..on(AppConstants.newMessageEvent, (messageData) {
        if (messageData['senderId'] == otherUserId &&
            messageData['receiverId'] == ref.read(appUserProvider)?.uid) {
          ref.read(messagesProvider.notifier).addMessage(
                Message.fromMap(messageData as Map<String, dynamic>),
              );
        }
      })
      ..on(AppConstants.userOnlineEvent, (userId) {
        if (userId == otherUserId) {
          ref.read(otherUserStatusProvider.notifier).setOnline();
        }
      })
      ..on(AppConstants.userOfflineEvent, (userId) {
        if (userId == otherUserId) {
          ref.read(otherUserStatusProvider.notifier).setOffline();
        }
      })
      ..on(AppConstants.userTypingEvent, (userId) {
        if (userId == otherUserId) {
          ref.read(otherUserStatusProvider.notifier).setTyping();
        }
      })
      ..on(AppConstants.userTypingEndEvent, (userId) {
        if (userId == otherUserId) {
          ref.read(otherUserStatusProvider.notifier).setOnline();
        }
      });
  }

  void sendTypingEvent() {
    state.emit(AppConstants.userTypingEvent, ref.read(appUserProvider)?.uid);
  }

  void sendTypingEndEvent() {
    state.emit(AppConstants.userTypingEndEvent, ref.read(appUserProvider)?.uid);
  }

  void requestUserStatus(String otherUserId) {
    state.emit(AppConstants.requestUserOnlineStatusEvent, otherUserId);
  }
}

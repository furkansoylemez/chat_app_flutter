import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/helper/other_helpers.dart';
import 'package:birsu/feature/chat/logic/chat_socket.dart';
import 'package:birsu/feature/chat/logic/messages.dart';
import 'package:birsu/feature/chat/logic/other_user_status.dart';
import 'package:birsu/feature/chat/view/chat_text_field.dart';
import 'package:birsu/feature/chat/view/message_box.dart';
import 'package:birsu/model/user_model.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:birsu/widgets/empty_avatar.dart';
import 'package:birsu/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ChatPage extends ConsumerStatefulWidget {
  const ChatPage(this.chatUser, {super.key});

  final UserModel chatUser;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  Timer? _debounceTimer;
  bool _isUserTyping = false;
  late final String conversationId;
  late final TextEditingController _messageController;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _messageController = TextEditingController();
    conversationId = generateConversationId(
      ref.read(appUserProvider)?.uid ?? '',
      widget.chatUser.uid,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messagesProvider.notifier).fetchMessageHistory(conversationId);
      ref
          .read(chatSocketProvider.notifier)
          .setSocketUserStatusEvents(widget.chatUser.uid);
      ref
          .read(chatSocketProvider.notifier)
          .requestUserStatus(widget.chatUser.uid);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socket = ref.watch(chatSocketProvider);
    final messages = ref.watch(messagesProvider);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: ListTile(
          leading: EmptyAvatar(radius: 20.r),
          title: Text(widget.chatUser.name),
          subtitle: Text(getUserStatusMessage(context)),
        ),
      ),
      body: Column(
        children: [
          messages.when(
            data: (messages) {
              if (messages.isNotEmpty) {
                return Scrollbar(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                    ),
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final reverseMessages = messages.reversed.toList();
                      final message = reverseMessages[index];
                      final isFromCurrentUser =
                          message.senderId != widget.chatUser.uid;
                      return MessageBox(
                        message: message,
                        isFromCurrentUser: isFromCurrentUser,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return CustomSpacer.column(8.h);
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            error: (error, _) {
              return ErrorView(
                onRetry: () {
                  ref
                      .read(messagesProvider.notifier)
                      .fetchMessageHistory(conversationId);
                },
                errorMessage: error.toString(),
              ).center;
            },
            loading: () {
              return const CircularProgressIndicator().center;
            },
          ).expanded,
          ColoredBox(
            color: Theme.of(context).colorScheme.onBackground,
            child: Row(
              children: [
                Expanded(
                  child: ChatTextField(
                    onChanged: _onChanged,
                    messageController: _messageController,
                  ).paddingOnly(left: 8.w, top: 4.h, bottom: 4.h),
                ),
                IconButton(
                  color: Theme.of(context).colorScheme.background,
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onChanged(String value) {
    if (value.isNotEmpty) {
      _debounceTimer?.cancel(); // Cancel any previous timer
      _debounceTimer = Timer(const Duration(seconds: 1), () {
        _isUserTyping = false;
        ref.read(chatSocketProvider.notifier).sendTypingEndEvent();
      });

      if (!_isUserTyping) {
        _isUserTyping = true;
        ref.read(chatSocketProvider.notifier).sendTypingEvent();
      }
    }
  }

  String getUserStatusMessage(BuildContext context) {
    final otherUserStatus = ref.watch(otherUserStatusProvider);
    switch (otherUserStatus) {
      case OtherUserStatusType.offline:
        return context.loc.offline;
      case OtherUserStatusType.online:
        return context.loc.online;
      case OtherUserStatusType.typing:
        return context.loc.typing;
      case null:
        return '';
    }
  }

  void _sendMessage() {
    final trimmedMessage = _messageController.text.trim();
    if (trimmedMessage.isNotEmpty) {
      ref.read(chatSocketProvider.notifier).sendMessage(
            trimmedMessage,
            widget.chatUser.uid,
          );

      _messageController.clear();
    }
  }
}

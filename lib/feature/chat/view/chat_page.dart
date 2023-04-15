import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/helper/other_helpers.dart';
import 'package:birsu/core/resource/resources.dart';
import 'package:birsu/feature/chat/logic/chat_socket.dart';
import 'package:birsu/feature/chat/logic/messages.dart';
import 'package:birsu/feature/chat/logic/other_user_status.dart';
import 'package:birsu/feature/chat/view/chat_text_field.dart';
import 'package:birsu/feature/chat/view/message_box.dart';
import 'package:birsu/model/app_user.dart';
import 'package:birsu/provider/app_theme_mode.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/widgets/common_lottie.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:birsu/widgets/empty_avatar.dart';
import 'package:birsu/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ChatPage extends ConsumerStatefulWidget {
  const ChatPage(this.chatUser, {super.key});

  final AppUser chatUser;

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
    final screenSize = MediaQuery.of(context).size;
    ref.watch(chatSocketProvider);
    final appThemeMode = ref.watch(appThemeModeProvider);
    final messages = ref.watch(messagesProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.chatUser.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              _getUserStatusMessage(context),
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
        actions: [EmptyAvatar(radius: 22.r).paddingOnly(right: 12.w)],
      ),
      body: Stack(
        children: [
          Container(
            height: screenSize.height,
            width: screenSize.width,
            foregroundDecoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.4),
            ),
            child: CommonLottie(
              appThemeMode == ThemeMode.light
                  ? AppLotties.ltLightChatBackground
                  : AppLotties.ltDarkChatBackground,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
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
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: ChatTextField(
                            onChanged: _updateTypingStatus,
                            messageController: _messageController,
                          ).paddingOnly(left: 8.w, top: 4.h, bottom: 4.h),
                        ).paddingOnly(left: 10.w, top: 10.h, bottom: 10.h),
                      ),
                      IconButton(
                        color: Theme.of(context).colorScheme.onBackground,
                        iconSize: 25.r,
                        onPressed: _sendMessageAndClearField,
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateTypingStatus(String value) {
    if (value.isNotEmpty) {
      _debounceTimer?.cancel();
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

  String _getUserStatusMessage(BuildContext context) {
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

  void _sendMessageAndClearField() {
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

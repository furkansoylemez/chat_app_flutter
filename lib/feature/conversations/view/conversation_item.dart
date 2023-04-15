import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/helper/other_helpers.dart';
import 'package:birsu/feature/conversations/logic/conversation_user.dart';
import 'package:birsu/model/app_user.dart';
import 'package:birsu/model/conversation.dart';
import 'package:birsu/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationItem extends ConsumerWidget {
  const ConversationItem({
    super.key,
    required this.conversation,
  });

  final Conversation conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otherUserData =
        ref.watch(conversationUserProvider(conversation.otherUserId));
    return otherUserData.when(
      data: (data) {
        final otherUser = AppUser.fromDocument(data);
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          leading: UserAvatar(imageUrl: otherUser.photoUrl, radius: 25.r),
          title: Text(otherUser.name),
          subtitle: Text(
            conversation.lastMessage.senderId == conversation.otherUserId
                ? conversation.lastMessage.content
                : context.loc.you(conversation.lastMessage.content),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(getMessageFormattedDate(conversation.timestamp)),
          onTap: () {
            _navigateChatPage(context, otherUser);
          },
        );
      },
      error: (error, _) {
        return const SizedBox.shrink();
      },
      loading: () {
        return const SizedBox.shrink();
      },
    );
  }

  void _navigateChatPage(BuildContext context, AppUser otherUser) {
    context.router.push(
      ChatRoute(
        chatUser: otherUser,
      ),
    );
  }
}

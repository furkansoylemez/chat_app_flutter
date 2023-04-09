import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/feature/conversations/logic/conversation_user.dart';
import 'package:birsu/model/conversation.dart';
import 'package:birsu/model/user_model.dart';
import 'package:birsu/widgets/empty_avatar.dart';
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
    final conversationUser =
        ref.watch(conversationUserProvider(conversation.otherUserId));
    return conversationUser.when(
      data: (data) {
        final chatUserModel = UserModel.fromDocument(data);
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          leading: EmptyAvatar(radius: 25.r),
          title: Text(chatUserModel.name),
          subtitle: Text(
            conversation.lastMessage.senderId == conversation.otherUserId
                ? conversation.lastMessage.content
                : context.loc.you(conversation.lastMessage.content),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(conversation.timestamp),
          onTap: () {},
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
}

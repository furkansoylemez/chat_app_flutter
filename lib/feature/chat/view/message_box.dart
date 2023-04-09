import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
    required this.isFromCurrentUser,
  });

  final MessageModel message;
  final bool isFromCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isFromCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isFromCurrentUser
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: getBorderRadius(),
        ),
        child: Text(
          message.content,
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ).paddingAll(16.r),
      ).paddingOnly(
        left: isFromCurrentUser ? 80.w : 10.w,
        right: isFromCurrentUser ? 10.w : 80.w,
      ),
    );
  }

  BorderRadius getBorderRadius() {
    if (isFromCurrentUser) {
      return BorderRadius.only(
        topLeft: Radius.circular(16.r),
        bottomLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      );
    } else {
      return BorderRadius.only(
        topRight: Radius.circular(16.r),
        bottomLeft: Radius.circular(16.r),
        bottomRight: Radius.circular(16.r),
      );
    }
  }
}

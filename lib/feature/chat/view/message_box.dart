import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/helper/other_helpers.dart';
import 'package:birsu/model/message.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
    required this.isFromCurrentUser,
  });

  final Message message;
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
        child: Column(
          crossAxisAlignment: isFromCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.content,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.background,
                fontWeight: FontWeight.w400,
              ),
            ),
            CustomSpacer.column(3.h),
            Text(
              getMessageFormattedDate(message.timestamp),
              style: TextStyle(
                fontSize: 11.sp,
                color: Theme.of(context).colorScheme.background,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
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

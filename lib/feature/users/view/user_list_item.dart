import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/model/app_user.dart';
import 'package:birsu/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 10.w,
      ),
      leading: UserAvatar(imageUrl: user.photoUrl, radius: 25.r),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context.router
          ..popUntilRouteWithName(ConversationsRoute.name)
          ..push(ChatRoute(chatUser: user));
      },
    );
  }
}

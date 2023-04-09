import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/feature/users/logic/users.dart';
import 'package:birsu/widgets/empty_avatar.dart';
import 'package:birsu/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(
      usersProvider,
    );

    return Scaffold(
      appBar: AppBar(),
      body: users.when(
        data: (data) {
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 10.w,
                  ),
                  leading: EmptyAvatar(
                    radius: 25.r,
                  ),
                  title: Text(data[index].name),
                  subtitle: Text(data[index].email),
                  onTap: () {
                    context.router
                      ..popUntilRouteWithName(ConversationsRoute.name)
                      ..push(ChatRoute(chatUser: data[index]));
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
        error: (error, _) {
          return ErrorView(
            errorMessage: error.toString(),
            onRetry: () {
              ref.read(usersProvider.notifier).retryFetchUsers();
            },
          );
        },
        loading: () {
          return const CircularProgressIndicator();
        },
      ).center,
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/feature/users/logic/users.dart';
import 'package:birsu/feature/users/view/user_list_item.dart';
import 'package:birsu/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(
      usersProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.users),
      ),
      body: users.when(
        data: (data) {
          if (data.isNotEmpty) {
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final user = data[index];
                return UserListItem(user: user);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
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

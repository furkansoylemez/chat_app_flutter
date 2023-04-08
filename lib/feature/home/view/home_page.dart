import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/feature/drawer/view/drawer_page.dart';
import 'package:birsu/feature/home/logic/home_users.dart';
import 'package:birsu/widgets/empty_avatar.dart';
import 'package:birsu/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(
      homeUsersProvider,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  Icons.menu_outlined,
                  size: 25.r,
                ),
              ).paddingOnly(right: 10.w);
            },
          )
        ],
      ),
      endDrawer: const DrawerPage(),
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
                  onTap: () {},
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
              ref.read(homeUsersProvider.notifier).retryFetchUsers();
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

import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/feature/drawer/logic/drawer_logout.dart';
import 'package:birsu/feature/drawer/view/drawer_list_tile.dart';
import 'package:birsu/feature/drawer/view/theme_switch_button.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:birsu/widgets/empty_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerPage extends ConsumerWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);
    final logoutStatus = ref.watch(drawerLogoutProvider);
    return Drawer(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EmptyAvatar(
                      radius: 35.r,
                    ),
                    Text(
                      appUser?.name ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  if (logoutStatus is AsyncLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DrawerListTile(
                    title: context.loc.logout,
                    iconData: Icons.logout,
                    onTap: () {
                      ref.read(drawerLogoutProvider.notifier).logout();
                    },
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          const ThemeSwitchButton(),
          CustomSpacer.column(20.h)
        ],
      ),
    );
  }
}

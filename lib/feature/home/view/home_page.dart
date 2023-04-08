import 'package:auto_route/auto_route.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/usecase/logout/sign_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);
    print(user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Selam ${user?.displayName}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home Page',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(signOutProvider.notifier).action();
              },
              child: const Text('Profile Page'),
            ),
          ],
        ),
      ),
    );
  }
}

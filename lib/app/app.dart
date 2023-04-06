import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/theme/app_theme.dart';
import 'package:birsu/provider/app_router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return ScreenUtilInit(
      builder: (_, __) {
        return MaterialApp.router(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router.config(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

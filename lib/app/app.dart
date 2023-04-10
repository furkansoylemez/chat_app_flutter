import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/theme/app_theme.dart';
import 'package:birsu/provider/app_theme_mode.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/widgets/dismissible_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    _listenUserLogOut(ref, router);
    return DismissibleBody(
      child: ScreenUtilInit(
        builder: (_, __) {
          return MaterialApp.router(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ref.watch(appThemeModeProvider),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: _localeResolutionCallback,
            routerConfig: router.config(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  Locale? _localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    if (locale == null) {
      return AppConstants.defaultLocale;
    }

    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }

    return AppConstants.defaultLocale;
  }

  void _listenUserLogOut(WidgetRef ref, AppRouter router) {
    ref.listen(appUserProvider, (prev, next) {
      if (prev != next && next == null) {
        router.pushAndPopUntil(const SplashRoute(), predicate: (_) => false);
      }
    });
  }
}

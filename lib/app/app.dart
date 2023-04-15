import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/notification_configurations.dart';
import 'package:birsu/core/theme/app_theme.dart';
import 'package:birsu/provider/app_theme_mode.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/widgets/dismissible_body.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    _handleNotification();
  }

  void _handleNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final router = ref.watch(appRouterProvider);
      final topRoute = router.topRoute;

      if (topRoute.args is ChatRouteArgs) {
        final args = topRoute.args as ChatRouteArgs;
        final chatUserid = args.chatUser.uid;
        final messageData = message.data;
        print('Buraya düştü');
        if (chatUserid != messageData['senderId']) {
          showFlutterNotification(message);
        }
      } else {
        showFlutterNotification(message);
      }

      print('A new onMessage event was published!');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  @override
  Widget build(BuildContext context) {
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

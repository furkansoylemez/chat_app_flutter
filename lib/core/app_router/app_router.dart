import 'package:auto_route/auto_route.dart';
import 'package:birsu/feature/home/view/home_page.dart';
import 'package:birsu/feature/login/view/login_page.dart';
import 'package:birsu/feature/splash/view/splash_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: SplashRoute.page,
      path: '/',
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
    ),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.custom(
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      );
}

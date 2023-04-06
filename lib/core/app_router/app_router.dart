import 'package:auto_route/auto_route.dart';
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
  ];
}

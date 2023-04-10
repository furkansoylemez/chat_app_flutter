import 'package:auto_route/auto_route.dart';
import 'package:birsu/feature/chat/view/chat_page.dart';
import 'package:birsu/feature/conversations/view/conversations_page.dart';
import 'package:birsu/feature/login/view/login_page.dart';
import 'package:birsu/feature/register/view/register_page.dart';
import 'package:birsu/feature/splash/view/splash_page.dart';
import 'package:birsu/feature/users/view/users_page.dart';
import 'package:birsu/model/app_user.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';
part 'app_router.gr.dart';

@riverpod
AppRouter appRouter(AppRouterRef ref) {
  return AppRouter();
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: SplashRoute.page,
      path: '/',
    ),
    AutoRoute(
      page: RegisterRoute.page,
      path: '/register',
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
    AutoRoute(
      page: UsersRoute.page,
      path: '/users',
    ),
    AutoRoute(
      page: ConversationsRoute.page,
      path: '/conversations',
    ),
    AutoRoute(
      page: ChatRoute.page,
      path: '/chat',
    ),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.custom(
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      );
}

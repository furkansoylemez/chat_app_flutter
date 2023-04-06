import 'package:birsu/core/app_router/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router_provider.g.dart';

@riverpod
AppRouter appRouter(AppRouterRef ref) {
  return AppRouter();
}

import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/resource/resources.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/widgets/common_lottie.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkCurrentUserAndNavigate();
  }

  void _checkCurrentUserAndNavigate() {
    Future.delayed(AppConstants.splashDuration, () {
      if (ref.read(appUserProvider) != null) {
        _replaceWithConversationsPage();
      } else {
        _replaceWithLoginPage();
      }
    });
  }

  void _replaceWithLoginPage() {
    context.router.replace(LoginRoute());
  }

  void _replaceWithConversationsPage() {
    context.router.replace(const ConversationsRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CommonLottie(AppLotties.ltCouple),
          CustomSpacer.column(20.h),
          const LinearProgressIndicator().paddingSymmetric(horizontal: 70.w)
        ],
      ),
    );
  }
}

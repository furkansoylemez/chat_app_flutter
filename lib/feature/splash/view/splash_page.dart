import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/resource/resources.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

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
    _checkAppUser();
  }

  void _checkAppUser() {
    Future.delayed(AppConstants.splashDuration, () {
      final appUser = ref.read(appUserProvider);
      if (appUser != null) {
        _replaceWithHomePage();
      } else {
        _replaceWithLoginPage();
      }
    });
  }

  void _replaceWithLoginPage() {
    context.router.replace(LoginRoute());
  }

  void _replaceWithHomePage() {
    context.router.replace(const HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AppLotties.ltCouple,
            frameRate: FrameRate.max,
            repeat: true,
            animate: true,
          ),
          CustomSpacer.column(20.h),
          const LinearProgressIndicator().paddingSymmetric(horizontal: 70.w)
        ],
      ),
    );
  }
}

import 'package:birsu/core/resource/resources.dart';
import 'package:birsu/provider/app_theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class ThemeSwitchButton extends ConsumerStatefulWidget {
  const ThemeSwitchButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ThemeSwitchButtonState();
}

class _ThemeSwitchButtonState extends ConsumerState<ThemeSwitchButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _initAnimationController();

    super.initState();
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    if (ref.read(appThemeModeProvider) == ThemeMode.light) {
      _animationController.value = 0;
    } else {
      _animationController.value = 0.5;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleTheme,
      child: LottieBuilder.asset(
        AppLotties.ltThemeSwitch,
        controller: _animationController,
        animate: false,
        fit: BoxFit.contain,
      ),
    );
  }

  void _toggleTheme() {
    final appThemeMode = ref.read(appThemeModeProvider);
    if (appThemeMode == ThemeMode.light) {
      _animationController.animateTo(0.5);
    } else {
      _animationController.animateTo(0);
    }
    ref.read(appThemeModeProvider.notifier).toggleMode();
  }
}

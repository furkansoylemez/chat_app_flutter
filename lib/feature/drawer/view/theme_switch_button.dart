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
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    final initialMode = ref.read(appThemeModeProvider);
    if (initialMode == ThemeMode.light) {
      _controller.value = 0;
    } else {
      _controller.value = 0.5;
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final appThemeMode = ref.read(appThemeModeProvider);
        if (appThemeMode == ThemeMode.light) {
          _controller.animateTo(0.5);
        } else {
          _controller.animateTo(0);
        }
        ref.read(appThemeModeProvider.notifier).toggleMode();
      },
      child: LottieBuilder.asset(
        AppLotties.ltThemeSwitch,
        controller: _controller,
        animate: false,
        fit: BoxFit.contain,
      ),
    );
  }
}

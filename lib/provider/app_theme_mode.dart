import 'package:birsu/core/helper/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_mode.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    final storage = ref.read(storageHelperProvider.notifier);

    if (storage.isLightTheme) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  void toggleMode() {
    if (state == ThemeMode.light) {
      _setDarkMode();
    } else {
      _setLightMode();
    }
  }

  void _setDarkMode() {
    ref.read(storageHelperProvider.notifier).setLightThemeFalse();
    state = ThemeMode.dark;
  }

  void _setLightMode() {
    ref.read(storageHelperProvider.notifier).setLightThemeTrue();
    state = ThemeMode.light;
  }
}

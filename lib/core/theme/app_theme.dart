import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData.light(
      useMaterial3: true,
    ).copyWith();
  }

  static ThemeData get dark {
    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith();
  }
}

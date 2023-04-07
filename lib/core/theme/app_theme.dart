import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData.light(
      useMaterial3: true,
    ).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith();
  }
}

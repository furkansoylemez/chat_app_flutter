import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toast_helper.g.dart';

@riverpod
ToastHelper toastHelper(ToastHelperRef ref) {
  return ToastHelper();
}

class ToastHelper {
  void showSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: message.length * 100),
      ),
    );
  }
}

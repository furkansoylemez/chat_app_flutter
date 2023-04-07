import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void onProviderErrorShowSnackBar<T>(
    WidgetRef ref,
    BuildContext context, {
    required List<ProviderListenable<AsyncValue<T>>> providers,
  }) {
    for (final provider in providers) {
      ref.listen(
        provider,
        (_, state) {
          if (state is AsyncError && state.hasError) {
            showSnackBar(context, state.error.toString());
          }
        },
      );
    }
  }
}

import 'package:birsu/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dialog_helper.g.dart';

@riverpod
DialogHelper dialogHelper(DialogHelperRef ref) {
  return DialogHelper();
}

class DialogHelper {
  Future<void> showDialogBox(
    BuildContext context, {
    required String title,
    required String content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      },
      barrierDismissible: barrierDismissible,
    );
  }

  void showErrorDialog(
    BuildContext context,
    Object? error,
  ) {
    showDialogBox(
      context,
      title: context.loc.errorTitle,
      content: error.toString(),
    );
  }

  void onAsyncErrorShowDialog(
    BuildContext context,
    AsyncValue<dynamic>? prevAsync,
    AsyncValue<dynamic> nextAsync,
  ) {
    if (prevAsync != nextAsync &&
        nextAsync is AsyncError &&
        nextAsync.hasError) {
      showErrorDialog(context, nextAsync.error);
    }
  }
}

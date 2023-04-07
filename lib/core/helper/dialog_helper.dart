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
    required Widget title,
    required Widget content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: content,
          actions: actions,
        );
      },
      barrierDismissible: barrierDismissible,
    );
  }
}

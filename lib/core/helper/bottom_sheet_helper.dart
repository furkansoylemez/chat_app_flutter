import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_sheet_helper.g.dart';

@riverpod
BottomSheetHelper bottomSheetHelper(BottomSheetHelperRef ref) {
  return BottomSheetHelper();
}

class BottomSheetHelper {
  void showBottomSheet(
    BuildContext context, {
    required Widget child,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
  }) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: child,
        );
      },
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
    );
  }
}

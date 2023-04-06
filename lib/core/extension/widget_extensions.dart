import 'package:flutter/material.dart';

extension AlignX on Widget {
  Center get center => Center(child: this);
}

extension PaddingX on Widget {
  Padding paddingOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left ?? 0,
          top: top ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0,
        ),
        child: this,
      );

  Padding paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Padding paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );
}

extension ExpandedX on Widget {
  Expanded get expanded => Expanded(child: this);
}

import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  factory CustomSpacer.row(double space) {
    return CustomSpacer._(width: space, height: 0);
  }

  factory CustomSpacer.column(double space) {
    return CustomSpacer._(width: 0, height: space);
  }

  const CustomSpacer._({required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}

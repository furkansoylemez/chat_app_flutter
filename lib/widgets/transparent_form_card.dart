import 'package:flutter/material.dart';

class TransparentFormCard extends StatelessWidget {
  const TransparentFormCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor.withOpacity(0.7),
      margin: EdgeInsets.zero,
      child: child,
    );
  }
}

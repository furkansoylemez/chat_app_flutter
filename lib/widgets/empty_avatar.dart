import 'package:flutter/material.dart';

class EmptyAvatar extends StatelessWidget {
  const EmptyAvatar({
    super.key,
    required this.radius,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      child: Icon(
        Icons.person,
        color: Theme.of(context).colorScheme.background,
        size: radius,
      ),
    );
  }
}

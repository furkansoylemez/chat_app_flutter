import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    this.onTap,
    required this.title,
    required this.iconData,
  });

  final void Function()? onTap;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: onTap,
    );
  }
}

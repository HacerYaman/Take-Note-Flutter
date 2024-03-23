import 'package:flutter/material.dart';

class CustomDrawerTile extends StatelessWidget {
  final String title;
  final Widget leading;
  final void Function()? onTap;
  const CustomDrawerTile(
      {super.key,
      required this.title,
      required this.leading,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        leading: leading,
        onTap: onTap,
      ),
    );
  }
}

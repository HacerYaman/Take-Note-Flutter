import 'package:flutter/material.dart';
import 'package:take_note/components/drawer_tile.dart';

import '../pages/settings_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const DrawerHeader(child: Icon(Icons.edit)),
          CustomDrawerTile(
              title: "Notes",
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              }),
          CustomDrawerTile(
              title: "Settings",
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              }),
        ],
      ),
    );
  }
}

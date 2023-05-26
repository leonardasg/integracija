import 'package:flutter/material.dart';
import 'drawer_pages/about.dart';
import 'drawer_pages/settings.dart';
import 'drawer_pages/instruction.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    const drawerHeader = DrawerHeader(child: Text('Meniu'));

    return Drawer(
      child: ListView(
        children: [
          drawerHeader,
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Programėlės nustatymai'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Naudojimo instrukcija'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InstructionPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

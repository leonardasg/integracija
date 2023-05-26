import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'General settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Allow notifications'),
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });

                  if (value) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Notifications allowed'),
                          content: const Text('Now you will get notifications'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else {
                    //TODO kai neleidžiami pranešimai
                  }
                },
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: Provider.of<ThemeManager>(context, listen: false).themeMode == ThemeMode.dark,
                onChanged: (value) {
                  setState(() { });
                  Provider.of<ThemeManager>(context, listen: false).toggleTheme(value);
                },
              ),
              const Divider(),
              const Text(
                'Language settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Lithuanian'),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/languages/lt.png'),
                ),
                onTap: () {
                  // TODO: Implement language selection
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('English'),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/languages/en.png'),
                ),
                onTap: () {
                  // TODO: Implement language selection
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
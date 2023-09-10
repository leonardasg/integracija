import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'package:integration_app/controllers/auth/login.dart';

class HeaderMenu extends StatefulWidget implements PreferredSizeWidget {
  const HeaderMenu({Key? key}) : super(key: key);

  @override
  MyAppBarState createState() => MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MyAppBarState extends State<HeaderMenu> {
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false;
    final profileIcon = IconButton(
      icon: isLoggedIn ? const Icon(Icons.logout) : const Icon(Icons.login),
      onPressed: () {
        if (!isLoggedIn) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Login();
            },
          );
        }
        else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Ar tikrai norite atsijungti?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLoggedIn = false;
                      });
                      //user.logout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const HomePage()),
                      );
                    },
                    child: const Text('Taip'),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    child: const Text('Ne'),
                  ),
                ],
              );
            },
          );
        }
      }
    );

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Builder(
        builder: (context) => AppBar(
          title: const Text('SHMgration'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          actions: [
            profileIcon,
          ],
        ),
      ),
    );
  }
}

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:integration_app/theme/theme_constants.dart';
import 'package:integration_app/theme/theme_manager.dart';
import 'package:integration_app/views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeManager _themeManager = ThemeManager();

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _themeManager),
        // other providers
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static Future<ThemeMode> getSavedThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? themeValue = prefs.getInt('themeMode');
    return themeValue != null ? ThemeMode.values[themeValue] : ThemeMode.system;
  }

  static Future<void> saveThemeMode(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', themeMode.index);
  }

}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
    loadSavedThemeMode();
  }

  void themeListener(){
    if(mounted){
      setState(() {
        MyApp.saveThemeMode(_themeManager.themeMode);
      });
    }
  }

  Future<void> loadSavedThemeMode() async {
    final ThemeMode savedThemeMode = await MyApp.getSavedThemeMode();
    setState(() {
      _themeManager.toggleTheme(savedThemeMode == ThemeMode.dark ? true : false);
    });
  }

  @override
  Widget build(BuildContext context) {
    late ConnectivityResult _connectivityResult;

    Future<bool> checkInternetConnection() async {
      _connectivityResult = await Connectivity().checkConnectivity();
      if (_connectivityResult == ConnectivityResult.none) {
        return false;
      }
      return true;
    }

    return MaterialApp(
      title: 'SHMgration',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: checkInternetConnection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while the future is still resolving
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );

            } else if (snapshot.hasError || snapshot.data == false) {
              // Display the AlertDialog if there is an error or if the API connection check failed
              return AlertDialog(
                title: const Text('Nėra interneto ryšio arba neprisijungta prie KTU VPN'),
                content: const Text('Prisijunkite prie KTU VPN ir bandykite jungtis dar kartą'),
                actions: [
                  TextButton(
                    child: const Text('Gerai'),
                    onPressed: () => SystemNavigator.pop(),
                  ),
                ],
              );
            } else {
              return const HomePage();
            }
          },
        ),
      ),
    );
  }
}

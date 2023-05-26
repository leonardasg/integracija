import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:integration_app/views/home_page_body_widgets/first.dart';
import 'package:integration_app/views/home_page_body_widgets/second.dart';
import 'package:integration_app/views/home_page_body_widgets/third.dart';
import 'header_menu.dart';
import 'drawer_menu.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({Key? key, this.initialIndex = 1}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;

  }

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  DateTime _lastPressedAt =  DateTime.now();

  // if back button pressed two times between 1 second then app is minimized
  Future<bool> _onBackPressed() async {
    DateTime now = DateTime.now();
    if (now.difference(_lastPressedAt) > const Duration(seconds: 1)) {
      _lastPressedAt = now;
      return false;
    }
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    const homePageBar = HeaderMenu();

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: homePageBar,
        drawer: const DrawerMenu(),
        body: Center(
          child: _getBodyWidget(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car_filled),
              label: 'Rezervacija',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Žemėlapis',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profilis',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: setSelectedIndex,
        ),
      ),
    );
  }

  Widget _getBodyWidget() {
    switch (selectedIndex) {
      case 0:
        return FirstPage();
      case 1:
        return const SecondPage();
      case 2:
        return const ThirdPage();
      default:
        return Container();
    }
  }
}

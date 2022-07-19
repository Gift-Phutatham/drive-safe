import 'package:flutter/material.dart';

import 'constants.dart';
import 'dashboard_screen.dart';
import 'map_screen.dart';
import 'my_account.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyMap(),
    DashBoardScreen(),
    MyAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem getNavigationItem(IconData iconData, String text) {
    return BottomNavigationBarItem(
      icon: Icon(iconData),
      activeIcon: Container(
        padding: const EdgeInsets.all(3.0),
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(iconData),
      ),
      label: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kMainColor,
        items: <BottomNavigationBarItem>[
          getNavigationItem(Icons.place, 'แผนที่'),
          getNavigationItem(Icons.bar_chart, 'สถิติ'),
          getNavigationItem(Icons.account_circle, 'บัญชีฉัน')
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: kMainColor),
        onTap: _onItemTapped,
      ),
    );
  }
}

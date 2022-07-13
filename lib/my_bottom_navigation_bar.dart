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
    MapSample(),
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
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
        backgroundColor: kBackgroundColor,
        items: <BottomNavigationBarItem>[
          getNavigationItem(Icons.place, 'แผนที่'),
          getNavigationItem(Icons.bar_chart, 'สถิติ'),
          getNavigationItem(Icons.account_circle, 'บัญชีฉัน')
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle:
            const TextStyle(fontFamily: 'Prompt', color: Colors.white),
        unselectedLabelStyle:
            const TextStyle(fontFamily: 'Prompt', color: Colors.white),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: kBackgroundColor),
        onTap: _onItemTapped,
      ),
    );
  }
}
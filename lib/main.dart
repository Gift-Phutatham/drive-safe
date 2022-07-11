import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_screen.dart';
import 'dashboard_screen.dart';
import 'constants.dart';

void main() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MapSample(),
    DashBoardScreen()
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

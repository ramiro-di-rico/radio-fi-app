import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'controls/radio-app-bar.dart';
import 'favorites-stations-screen.dart';
import 'main-screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  List<Widget> children = [
    MainScreen(),
    FavoritesStationsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;

    var current = brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();

    return new MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: new Scaffold(
        appBar: _selectedIndex == 0 ? RadioAppBar() : AppBar(title: Text('Radio App'),),
        body: children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: current.bottomAppBarColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.radio),
              label: 'Estaciones de Radio'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_rate),
              label: 'Estaciones Favoritas'
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[400],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

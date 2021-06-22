import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'info-scree.dart';
import 'main-screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routes: {
        MainScreen.id: (context) => MainScreen(),
        InfoScreen.id: (context) => InfoScreen()
      },
      initialRoute: MainScreen.id,
    );
  }
}

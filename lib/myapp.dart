import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'controls/radio-app-bar.dart';
import 'main-screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.dark(),
      home: new Scaffold(
        appBar: RadioAppBar(),
        body: MainScreen(),
      ),
    );
  }
}

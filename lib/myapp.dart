import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'data/station-controller.dart';
import 'main-screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StationsController _stationsController = GetIt.instance<StationsController>();

  @override
  void initState() {
    super.initState();
    _stationsController.addListener(updateStationsList);
    _stationsController.start();
  }

  @override
  void dispose() {
    _stationsController.removeListener(updateStationsList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.dark(),
      home: new Scaffold(
        appBar: AppBar(
          title: Text('Radiofi'),
        ),
        body: MainScreen(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: !_stationsController.isSearching()
            ? FloatingActionButton(
                mini: true,
                onPressed: () {
                  _stationsController.changeTextEditState(true);
                },
                child: Icon(Icons.search),
              )
            : null,
      ),
    );
  }

    void updateStationsList() {
    setState(() {});
  }
}

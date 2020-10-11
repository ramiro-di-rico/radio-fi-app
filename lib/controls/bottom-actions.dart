import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../data/station-controller.dart';
import 'station-controls.dart';
import 'station-search.dart';

class BottomActionWdiget extends StatefulWidget {
  @override
  _BottomActionWdigetState createState() => _BottomActionWdigetState();
}

class _BottomActionWdigetState extends State<BottomActionWdiget> {
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
    return Container(
        color: ThemeData.dark().bottomAppBarColor,
        child: Column(children: [
          _stationsController.isSearching()
              ? StationSearchWidget()
              : StationsControlsWdiget()
        ]));
  }

  void updateStationsList() {
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'controls/bottom-actions.dart';
import 'controls/stations-listview.dart';
import 'data/station-controller.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    return new Center(
      child: _stationsController.stations.length == 0
          ? Text('No Stations Availabe.')
          : Column(
              children: _stationsController.isPlaying()
                  ? [
                      Expanded(flex: 9, child: StationsListView()),
                      Expanded(
                        flex: 1,
                        child: BottomActionWdiget(),
                      )
                    ]
                  : [Expanded(flex: 9, child: StationsListView())]),
    );
  }

  void updateStationsList() {
    setState(() {});
  }
}

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
  }

  @override
  void dispose() {
    _stationsController.removeListener(updateStationsList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          children: _stationsController.isPlaying()
              ? [
                  Expanded(child: StationsListView()),
                  Baseline(
                      baseline: 30,
                      baselineType: TextBaseline.alphabetic,
                      child: BottomActionWdiget(),
                    )
                ]
              : [Expanded(child: StationsListView())]),
    );
  }

  void updateStationsList() {
    setState(() {});
  }
}

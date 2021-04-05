import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../data/station-controller.dart';
import 'station-controls.dart';

class BottomActionWidget extends StatefulWidget {
  @override
  _BottomActionWidgetState createState() => _BottomActionWidgetState();
}

class _BottomActionWidgetState extends State<BottomActionWidget> {
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
    return Container(
        color: Theme.of(context).bottomAppBarColor,
        child: StationsControlsWidget());
  }

  void updateStationsList() {
    setState(() {});
  }
}

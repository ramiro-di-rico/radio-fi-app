import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'controls/bottom-actions.dart';
import 'controls/radio-app-bar.dart';
import 'controls/stations-listview.dart';
import 'services/controllers/station-controller.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

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
    var isPlaying = _stationsController.isPlaying();
    return Scaffold(
      appBar: RadioAppBar(),
      body: Center(
        child: Column(children: [
          Expanded(child: StationsListView()),
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: isPlaying ? 1.0 : 0.0,
            child: Baseline(
              baseline: isPlaying ? 30 : 0,
              baselineType: TextBaseline.alphabetic,
              child: BottomActionWidget(),
            ),
          )
        ]),
      ),
    );
  }

  void updateStationsList() {
    setState(() {});
  }
}

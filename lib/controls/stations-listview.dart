import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_fi/data/station-controller.dart';

import 'station-tile.dart';

class StationsListView extends StatefulWidget {
  @override
  _StationsListViewState createState() => _StationsListViewState();
}

class _StationsListViewState extends State<StationsListView> {
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
    return ListView.builder(
        itemCount: _stationsController.stations.length,
        itemBuilder: (context, index) {
          var station = _stationsController.stations[index];

          return ListTile(
            title: StationText(
              stationTitle: station.name,
              isPlaying: _stationsController.isPlayingStation(station),
            ),
            onTap: () async {
              _stationsController.play(station);
            },
          );
        });
  }

  void updateStationsList() {
    setState(() {});
  }
}

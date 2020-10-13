import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_fi/data/station-controller.dart';
import 'picture-widget.dart';
import 'station-tile.dart';

class StationsListView extends StatefulWidget {
  @override
  _StationsListViewState createState() => _StationsListViewState();
}

class _StationsListViewState extends State<StationsListView> {
  StationsController _stationsController = GetIt.instance<StationsController>();
  String defaultImage = 'https://image.shutterstock.com/image-photo/retro-outdated-portable-stereo-boombox-600w-720777676.jpg';

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
    return ListView.builder(
        itemCount: _stationsController.stations.length,
        itemBuilder: (context, index) {
          var station = _stationsController.stations[index];

          return ListTile(
            leading: PictureWidget(station.imageUrl.length > 0 ? station.imageUrl : defaultImage),
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

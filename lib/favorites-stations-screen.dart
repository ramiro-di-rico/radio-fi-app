import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'controls/bottom-actions.dart';
import 'controls/picture-widget.dart';
import 'controls/station-tile.dart';
import 'data/station-controller.dart';
import 'data/station.dart';

class FavoritesStationsScreen extends StatefulWidget {
  @override
  _FavoritesStationsScreenState createState() =>
      _FavoritesStationsScreenState();
}

class _FavoritesStationsScreenState extends State<FavoritesStationsScreen> {
  StationsController _stationsController = GetIt.instance<StationsController>();
  String defaultImage = 'https://image.shutterstock.com/image-photo/retro-outdated-portable-stereo-boombox-600w-720777676.jpg';
  List<Station> stations = [];

  @override
  void initState() {
    super.initState();
    _stationsController.addListener(updateStationsList);
    stations.addAll(_stationsController.stations.where((element) => element.star).toList());
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
                  Expanded(
                      flex: _stationsController.isSearching() ? 3 : 9,
                      child: buildListView()),
                  Expanded(
                    flex: 1,
                    child: BottomActionWdiget(),
                  )
                ]
              : [Expanded(flex: 9, child: buildListView())]));
  }

  ListView buildListView() {
    return ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            var station = stations[index];

            return ListTile(
              leading: PictureWidget(station.imageUrl.length > 0
                  ? station.imageUrl
                  : defaultImage),
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
    setState(() {
      stations.clear();
      stations.addAll(_stationsController.stations.where((element) => element.star).toList());
    });
  }
}

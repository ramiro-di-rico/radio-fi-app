import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_fi/data/station-controller.dart';
import 'picture-widget.dart';

class StationsListView extends StatefulWidget {
  @override
  _StationsListViewState createState() => _StationsListViewState();
}

class _StationsListViewState extends State<StationsListView> {
  StationsController _stationsController = GetIt.instance<StationsController>();
  String defaultImage =
      'https://image.shutterstock.com/image-photo/retro-outdated-portable-stereo-boombox-600w-720777676.jpg';
  ScrollController _scrollController = ScrollController();

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
        controller: _scrollController,
        itemCount: _stationsController.stations.length,
        itemBuilder: (context, index) {
          var station = _stationsController.stations[index];
          var isPlaying = _stationsController.isPlayingStation(station);
          return Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 3,
                    color: isPlaying ? Colors.blueAccent : Colors.transparent),
                borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              leading: PictureWidget(station.imageUrl.length > 0
                  ? station.imageUrl
                  : defaultImage),
              title: Text(
                station.name,
              ),
              trailing: TextButton(
                  onPressed: () {
                    setState(() {
                      _stationsController.setFavorite(station, !station.star);
                    });
                  },
                  child: Icon(station.star ? Icons.star : Icons.star_outline)),
              onTap: () async {
                _stationsController.play(station);
              },
            ),
          );
        });
  }

  void updateStationsList() {
    setState(() {
      var stationIndex = _stationsController.getDisplayedStationIndex();
      if (stationIndex > 0) {
        var value = double.parse((stationIndex * 64).toString());
        _scrollController.animateTo(value,
            duration: Duration(seconds: 2), curve: Curves.easeIn);
      }
    });
  }
}

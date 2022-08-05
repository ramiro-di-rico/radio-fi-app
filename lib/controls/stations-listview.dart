import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/controllers/player-controller.dart';
import '../services/station-manager.dart';
import 'picture-widget.dart';

class StationsListView extends StatefulWidget {
  @override
  _StationsListViewState createState() => _StationsListViewState();
}

class _StationsListViewState extends State<StationsListView> {
  StationManager _stationsController = GetIt.instance<StationManager>();
  ScrollController _scrollController = ScrollController();
  PlayerController _player = GetIt.instance<PlayerController>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _stationsController.addListener(updateStationsList);
    _player.addListener(updateIsLoading);
  }

  @override
  void dispose() {
    _stationsController.removeListener(updateStationsList);
    _player.removeListener(updateIsLoading);
    super.dispose();
  }

  void updateIsLoading() {
    setState(() {
      _isLoading = _player.isLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _stationsController.stations.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            controller: _scrollController,
            itemCount: _stationsController.stations.length,
            itemBuilder: (context, index) {
              var station = _stationsController.stations[index];
              var isPlaying = _player.isPlayingStation(station);
              return Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 3,
                        color:
                            isPlaying ? Colors.blueAccent : Colors.transparent),
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading:
                      _isLoading && station.id == _player.getCurrentStation().id
                          ? CircularProgressIndicator()
                          : PictureWidget(station.imageUrl),
                  title: Text(
                    station.name,
                  ),
                  trailing: TextButton(
                      onPressed: () {
                        setState(() {
                          _stationsController.setFavorite(
                              station, !station.star);
                        });
                      },
                      child:
                          Icon(station.star ? Icons.star : Icons.star_outline)),
                  onTap: () async {
                    _player.play(station);
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

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/controllers/player-controller.dart';
import '../services/station-manager.dart';

class BottomActionWidget extends StatefulWidget {
  @override
  _BottomActionWidgetState createState() => _BottomActionWidgetState();
}

class _BottomActionWidgetState extends State<BottomActionWidget> {
  StationManager _stationsController = GetIt.instance<StationManager>();
  PlayerController _player = GetIt.instance<PlayerController>();
  double volume = 1.0;

  @override
  void initState() {
    super.initState();
    _stationsController.addListener(updateStationsList);
    updateVolume();
  }

  @override
  void dispose() {
    _stationsController.removeListener(updateStationsList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_player.isPlaying()) return Container();
    var currentStation = _player.getCurrentStation();

    return Container(
      color: Theme.of(context).bottomAppBarTheme.color,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextButton(
              onPressed: () {}, //() => _player.displayCurrentStation(),
              child: Text(currentStation.name.length > 10
                  ? currentStation.name.substring(0, 10)
                  : currentStation.name),
            ),
          ),
          Expanded(
            flex: 3,
            child: Slider(
              value: volume,
              onChanged: setVolume,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              child: Icon(Icons.stop),
              onPressed: () async {
                setState(() {
                  _player.stop();
                });
              },
            ),
          )
        ],
      ),
    );
  }

  void updateStationsList() {
    setState(() {
      updateVolume();
    });
  }

  void updateVolume() {
    volume = _player.getVolume();
  }

  void setVolume(double vol) {
    setState(() {
      volume = vol;
      _player.changeVolume(vol);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/controllers/player-controller.dart';
import '../services/controllers/station-controller.dart';

class BottomActionWidget extends StatefulWidget {
  @override
  _BottomActionWidgetState createState() => _BottomActionWidgetState();
}

class _BottomActionWidgetState extends State<BottomActionWidget> {
  StationsController _stationsController = GetIt.instance<StationsController>();
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
    var currentStation = _player.getCurrentStation();

    if (currentStation == null) return Container();

    return Container(
      color: Theme.of(context).bottomAppBarColor,
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

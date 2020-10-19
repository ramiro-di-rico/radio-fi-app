import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_fi/data/station-controller.dart';

class StationsControlsWdiget extends StatefulWidget {
  @override
  _StationsControlsWdigetState createState() => _StationsControlsWdigetState();
}

class _StationsControlsWdigetState extends State<StationsControlsWdiget> {
  StationsController _stationsController = GetIt.instance<StationsController>();
  double volume = 1.0;

  @override
  void initState() {
    super.initState();
    _stationsController.addListener(updateStationsList);
    volume = _stationsController.getVolume();
  }

  @override
  void dispose() {
    _stationsController.removeListener(updateStationsList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentStation = _stationsController.getCurrentStation();

    return ListTile(
      title: Row(
        children: [
          Text(currentStation != null ? currentStation.name : ''),
          Expanded(
            child: Slider(
                value: volume,
                onChanged: (vol) {
                  setState(() {
                    volume = vol;
                    _stationsController.changeVolumen(vol);
                  });
                }),
          )
        ],
      ),
      trailing: FlatButton(
        child: Icon(Icons.stop),
        onPressed: () async {
          setState(() {
            _stationsController.stop();
          });
        },
      ),
    );
  }

  void updateStationsList() {
    setState(() {});
  }
}

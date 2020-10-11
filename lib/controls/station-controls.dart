import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_fi/data/station-controller.dart';

class StationsControlsWdiget extends StatefulWidget {
  @override
  _StationsControlsWdigetState createState() => _StationsControlsWdigetState();
}

class _StationsControlsWdigetState extends State<StationsControlsWdiget> {
  StationsController _stationsController = GetIt.instance<StationsController>();

  @override
  Widget build(BuildContext context) {
    var currentStation = _stationsController.getCurrentStation();

    return ListTile(
      title: Text(currentStation != null ? currentStation.name : ''),
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
}

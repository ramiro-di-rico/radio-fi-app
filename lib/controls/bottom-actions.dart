import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../data/station-controller.dart';
import '../data/station.dart';

class BottomActionWdiget extends StatefulWidget {
  @override
  _BottomActionWdigetState createState() => _BottomActionWdigetState();
}

class _BottomActionWdigetState extends State<BottomActionWdiget> {
  StationsController _stationsController = GetIt.instance<StationsController>();
  bool isPlaying = false;
  Station currentStation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() { 
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    currentStation = _stationsController.getCurrentStation();
    isPlaying = _stationsController.isPlaying();

    return Container(
        color: ThemeData.dark().bottomAppBarColor,
        child: Column(
          children: [
            ListTile(
              title: Text( currentStation != null ?
                    currentStation.name : 
                    ''),
              trailing: FlatButton(
                child: Icon(Icons.stop),
                onPressed: () async {
                  setState(() {
                    _stationsController.stop();
                  });
                },
              ),
            ),
          ],
        ),
      );
  }
}
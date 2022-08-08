import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'controls/bottom-actions.dart';
import 'controls/radio-app-bar.dart';
import 'controls/stations-listview.dart';
import 'services/controllers/player-controller.dart';
import 'services/station-manager.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  StationManager _stationsController = GetIt.instance<StationManager>();
  PlayerController _player = GetIt.instance<PlayerController>();
  bool _displayBottomBar = false;
  bool _isConnected = true;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _stationsController.addListener(updateStationsList);
    _player.addListener(updateStationsList);
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((event) {
      _isConnected = event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile ||
          event == ConnectivityResult.ethernet;
    });
  }

  @override
  void dispose() {
    _stationsController.removeListener(updateStationsList);
    _player.removeListener(updateStationsList);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RadioAppBar(),
      body: _isConnected
          ? Column(children: [
              Expanded(child: StationsListView()),
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: _displayBottomBar ? 1.0 : 0.0,
                child: Baseline(
                  baseline: _displayBottomBar ? 30 : 0,
                  baselineType: TextBaseline.alphabetic,
                  child: BottomActionWidget(),
                ),
              )
            ])
          : Center(
              child: Text('No Internet connection detected.'),
            ),
    );
  }

  void updateStationsList() {
    setState(() {
      _displayBottomBar = _player.isPlaying() && !_player.isLoading();
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_radio/flutter_radio.dart';

import 'station.dart';
import 'stations-repository.dart';

class StationsController extends ChangeNotifier{
  StationsRepository _stationsRepository = StationsRepository();
  Station _current;
  bool _isPlaying = false;
  List<Station> stations = [];

  StationsController(){
    _stationsRepository.syncStations();
    _stationsRepository.addListener(updateStationsList);
  }

  Future<void> start() async {
    await FlutterRadio.audioStart();
  }

  Future changePlayingStatus() async {
    _isPlaying = await FlutterRadio.isPlaying();
    notifyListeners();
  }

  void updateStationsList() {
    stations = _stationsRepository.stations;
    notifyListeners();
  }

  void setStation(Station station) async {
    this._current = station;
    this._isPlaying = this._current != null;
    notifyListeners();
  }

  void play(Station station) async {
    await FlutterRadio.play(url: station.uri);
    setStation(station);
  }

  void stop() async {
    await FlutterRadio.stop();
    setStation(null);
  }

  bool isPlaying() => _isPlaying;

  bool isPlayingStation(Station station) => _current == station;

  Station getCurrentStation() => _current;
}
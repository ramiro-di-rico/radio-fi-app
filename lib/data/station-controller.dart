import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'station.dart';
import 'package:http/http.dart' as http;

class StationsController extends ChangeNotifier {
  AudioPlayer _flutterRadioPlayer = new AudioPlayer();
  Station _current;
  bool _isPlaying = false;
  String _searchText = '';
  bool _editSearchText = false;
  double _volume = 1.0;
  List<Station> stations = [];
  List<Station> _internalStations = [];
  int _index = -1;

  StationsController() {
    _load();
  }

  void play(Station station) async {
    await _flutterRadioPlayer.setUrl(station.uri);
    await _flutterRadioPlayer.setVolume(_volume);
    await _flutterRadioPlayer.play();
    _setStation(station);
  }

  void stop() async {
    await _flutterRadioPlayer.stop();
    _volume = 1.0;
    _setStation(null);
  }

  void changeVolume(double vol) async {
    _volume = vol;
    await _flutterRadioPlayer.setVolume(_volume);
    notifyListeners();
  }

  double getVolume() => _volume;

  bool isPlaying() => _isPlaying;

  bool isPlayingStation(Station station) => _current == station;

  Station getCurrentStation() => _current;

  changeTextEditState(bool value) {
    _editSearchText = value;

    if (!_editSearchText) _refreshStations();
    notifyListeners();
  }

  search(String value) {
    _searchText = value;

    if (_searchText.length > 0) {
      stations = _internalStations
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    } else {
      _refreshStations();
    }

    notifyListeners();
  }

  bool isSearching() => _editSearchText;

  void _refreshStations() {
    stations = [];
    stations.addAll(_internalStations);
    notifyListeners();
  }

  void _setStation(Station station) async {
    this._current = station;
    this._isPlaying = this._current != null;
    notifyListeners();
  }

  void displayCurrentStation() {
    _index = stations.indexOf(_current);
    notifyListeners();
  }

  int getDisplayedStationIndex() {
    var index = _index;
    _index = -1;
    return index;
  }

  Future _load() async {
    var data = await _getStations();
    _internalStations.addAll(data);
    _refreshStations();
  }

  Future<List<Station>> _getStations() async {
    var queryParameters = {'Active': 'true'};

    var response = await http.get(Uri.https(
        "ramiro-di-rico.dev", "radioapi/api/stations", queryParameters));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      var result = data.map((e) => Station.fromJson(e)).toList();
      return result;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return List.empty();
    }
  }
}

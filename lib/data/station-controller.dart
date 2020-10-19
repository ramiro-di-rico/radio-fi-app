import 'package:flutter/cupertino.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'station.dart';
import 'stations-repository.dart';

class StationsController extends ChangeNotifier {
  StationsRepository _stationsRepository = StationsRepository();
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
  bool _initialized = false;
  Station _current;
  bool _isPlaying = false;  
  String _searchText = '';
  bool _editSearchText = false;
  double _volume = 1.0;
  List<Station> stations = [];

  StationsController() {
    _stationsRepository.syncStations();
    _stationsRepository.addListener(updateStationsList);
  }

  void updateStationsList() {
    _refreshStations();
    notifyListeners();
  }

  void play(Station station) async {
    if (!_initialized) {
      await _flutterRadioPlayer.init('Radio Fi', 'Live', station.uri, true.toString());
      _initialized = true;
    } 
    else{
      _flutterRadioPlayer.setUrl(station.uri, true.toString());
      await _flutterRadioPlayer.setVolume(_volume);
    }

    _setStation(station);
  }

  void stop() async {
    await _flutterRadioPlayer.stop();
    _volume = 1.0;
    _setStation(null);
    _initialized = false;
  }

  void changeVolumen(double vol) async {
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
      stations = _stationsRepository.stations
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    } else {
      _refreshStations();
    }

    notifyListeners();
  }

  void setFavorite(Station station, bool star) {
    if (star) {
      _stationsRepository.star(station);
    } else {
      _stationsRepository.unstar(station);
    }
  }

  bool isSearching() => _editSearchText;

  void _refreshStations() {
    stations = [];
    stations.addAll(_stationsRepository.stations);
  }

  void _setStation(Station station) async {
    this._current = station;
    this._isPlaying = this._current != null;
    notifyListeners();
  }
}

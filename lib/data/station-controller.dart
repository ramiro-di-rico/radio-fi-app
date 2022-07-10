import 'package:flutter/cupertino.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:just_audio/just_audio.dart';
import 'station.dart';
import 'stations-service.dart';

class StationsController extends ChangeNotifier {
  StationsService _stationsRepository = StationsService();
  //FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
  AudioPlayer _flutterRadioPlayer = new AudioPlayer();
  bool _initialized = false;
  Station _current;
  bool _isPlaying = false;
  String _searchText = '';
  bool _editSearchText = false;
  double _volume = 1.0;
  List<Station> stations = [];
  int _index = -1;

  StationsController() {
    _stationsRepository.loadCountryCodes();
    _stationsRepository.syncStations();
    _stationsRepository.addListener(updateStationsList);
  }

  void updateStationsList() {
    _refreshStations();
    notifyListeners();
  }

  void play(Station station) async {
    if (!_initialized) {
      /*
      await _flutterRadioPlayer.init(
          'Radio Fi', 'Live', station.uri, true.toString());
          */
      //_flutterRadioPlayer.setUrl(station.uri);
      _initialized = true;
    } else {
      _flutterRadioPlayer.setUrl(station.uri);
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
    if (!isSearching()) {
      _refreshStations();
    }
  }

  bool isSearching() => _editSearchText;

  void _refreshStations() {
    stations = [];
    stations
        .addAll(_stationsRepository.stations.where((element) => element.star));
    stations
        .addAll(_stationsRepository.stations.where((element) => !element.star));
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

  List<String> getCountryCodes() => _stationsRepository.countryCodes;

  void changeCountryCode(String countryCode) {
    _stationsRepository.changeCountryCode(countryCode);
  }
}

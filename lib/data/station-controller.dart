import 'package:flutter/cupertino.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'station.dart';
import 'stations-repository.dart';

class StationsController extends ChangeNotifier{
  StationsRepository _stationsRepository = StationsRepository();
  Station _current;
  bool _isPlaying = false;
  List<Station> stations = [];
  String _searchText = '';
  bool _editSearchText = false;

  StationsController(){
    _stationsRepository.syncStations();
    _stationsRepository.addListener(updateStationsList);
  }

  Future<void> start() async {
    await FlutterRadio.audioStart();
  }

  void updateStationsList() {
    _refreshStations();
    notifyListeners();
  }

  void play(Station station) async {

    if(_isPlaying) stop();

    await FlutterRadio.play(url: station.uri);
    _setStation(station);
  }

  void stop() async {
    await FlutterRadio.stop();
    _setStation(null);
  }  

  bool isPlaying() => _isPlaying;

  bool isPlayingStation(Station station) => _current == station;

  Station getCurrentStation() => _current;

    void _setStation(Station station) async {
    this._current = station;
    this._isPlaying = this._current != null;
    notifyListeners();
  }

  changeTextEditState(bool value){
    _editSearchText = value;

    if(!_editSearchText) _refreshStations();
    notifyListeners();
  }

  search(String value){
    _searchText = value;

    if(_searchText.length > 0){
      stations.removeWhere((element) => !element.name.toLowerCase().contains(_searchText.toLowerCase()));
    }else{
      _refreshStations();
    }

    notifyListeners();
  }

  bool isSearching() => _editSearchText;

  void _refreshStations(){
    stations = [];
    stations.addAll(_stationsRepository.stations);
  }
}
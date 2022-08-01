import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_fi/data/station.dart';
import 'package:radio_fi/services/station-player.dart';

class PlayerController extends ChangeNotifier implements StationPlayer {
  AudioPlayer _flutterRadioPlayer = new AudioPlayer();
  Station _current;
  bool _isPlaying = false;
  double _volume = 1.0;

  @override
  Future changeVolume(double newVolume) async {
    _volume = newVolume;
    await _flutterRadioPlayer.setVolume(_volume);
    notifyListeners();
  }

  @override
  Station getCurrentStation() => _current;

  @override
  double getVolume() => _volume;

  @override
  bool isPlaying() => _isPlaying;

  @override
  bool isPlayingStation(Station station) => _current == station;

  @override
  Future play(Station station) async {
    await _flutterRadioPlayer.setUrl(station.uri);
    await _flutterRadioPlayer.setVolume(_volume);
    await _flutterRadioPlayer.play();
    _setStation(station);
  }

  @override
  Future stop() async {
    await _flutterRadioPlayer.stop();
    _volume = 1.0;
    _setStation(null);
  }

  void _setStation(Station station) async {
    this._current = station;
    this._isPlaying = this._current != null;
    notifyListeners();
  }
}

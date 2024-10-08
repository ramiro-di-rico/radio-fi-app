import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/station.dart';
import '../station-player.dart';

class PlayerController extends ChangeNotifier implements StationPlayer {
  AudioPlayer _flutterRadioPlayer = new AudioPlayer();
  StreamSubscription<PlayerState>? playerStateSubscription;
  Station? _current;
  bool _isPlaying = false;
  double _volume = 1.0;
  bool _isLoading = false;

  @override
  Future changeVolume(double newVolume) async {
    _volume = newVolume;
    await _flutterRadioPlayer.setVolume(_volume);
    notifyListeners();
  }

  @override
  Station getCurrentStation() => _current!;

  @override
  double getVolume() => _volume;

  @override
  bool isPlaying() => _isPlaying;

  @override
  bool isLoading() => _isLoading;

  @override
  bool isPlayingStation(Station station) => _current == station;

  @override
  Future play(Station station) async {
    try {
      _setStation(station);
      _notifyLoading(true);
      await _flutterRadioPlayer.setUrl(station.uri);
      await _flutterRadioPlayer.setVolume(_volume);
      _flutterRadioPlayer.play();
      playerStateSubscription =
          _flutterRadioPlayer.playerStateStream.listen(_onPlayerStateChanged);
    } catch (e) {
    } finally {
      _notifyLoading(false);
    }
  }

  @override
  Future stop() async {
    await _flutterRadioPlayer.stop();
    _setStation(null);
    _notifyLoading(false);
    playerStateSubscription?.cancel();
  }

  void _setStation(Station? station) async {
    this._current = station;
    this._isPlaying = this._current != null;
  }

  void _notifyLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _onPlayerStateChanged(PlayerState state) {
    print(state);
  }
}

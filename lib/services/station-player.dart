import '../data/station.dart';

abstract class StationPlayer {
  Future play(Station station);
  Future stop();
  Future changeVolume(double newVolume);
  double getVolume();
  bool isPlaying();
  bool isPlayingStation(Station station);
  bool isLoading();
  Station getCurrentStation();
}

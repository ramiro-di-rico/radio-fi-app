import '../data/station.dart';

abstract class StationManager {
  Iterable<Station> search(String stationName);
  void setFavorite(Station station, bool star);
}

import '../data/station.dart';

abstract class StationManager {
  Iterable<Station> search(String stationName);
  Future<List<Station>> getStations();
  void setFavorite(Station station, bool star);
}

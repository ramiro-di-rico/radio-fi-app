import '../data/station.dart';

abstract class StationStorage {
  Future<List<Station>> getStations();
  Future<List<Station>> getStationsByCountryCode(String countryCode);
  Future update(Station station);
  Future bulkAdd(List<Station> stations);
}

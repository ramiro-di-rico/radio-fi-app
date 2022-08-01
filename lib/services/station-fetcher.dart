import '../data/station.dart';

abstract class StationFetcher {
  Future<List<Station>> getStations();
  Future<List<Station>> getStationsByContryCode(String countryCode);
}

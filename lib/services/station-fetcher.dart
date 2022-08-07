import '../data/station.dart';

abstract class StationFetcher {
  Future<List<Station>> getStations();
}

abstract class GeoStationFetcher {
  Future<List<Station>> getStationsByCountryCode(String countryCode);
}

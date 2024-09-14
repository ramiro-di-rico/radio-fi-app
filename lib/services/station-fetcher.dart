import '../data/station.dart';

abstract class StationFetcher {
  Future<List<Station>> getStations();
}

abstract mixin class GeoStationFetcher {
  Future<List<Station>> getStationsByCountryCode(String countryCode);
  void SetActiveFiltering(bool active);
}

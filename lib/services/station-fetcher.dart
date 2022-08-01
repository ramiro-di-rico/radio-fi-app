import '../data/station.dart';

abstract class StationFetcher {
  Future<List<Station>> getStations();
}

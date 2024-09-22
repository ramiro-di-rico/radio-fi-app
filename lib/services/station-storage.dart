import '../data/station.dart';
import 'station-fetcher.dart';

abstract class StationStorage extends StationFetcher with GeoStationFetcher {
  Future update(Station station);
  Future bulkAdd(List<Station> stations);
  Future<bool> isEmpty();
}

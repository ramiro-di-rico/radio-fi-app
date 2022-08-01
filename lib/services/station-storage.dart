import 'package:radio_fi/services/station-fetcher.dart';

import '../data/station.dart';

abstract class StationStorage extends StationFetcher with GeoStationFetcher {
  Future update(Station station);
  Future bulkAdd(List<Station> stations);
  Future<bool> isEmpty();
}

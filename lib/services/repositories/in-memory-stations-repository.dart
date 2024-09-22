import '../../data/station.dart';
import '../station-storage.dart';

class InMemoryStationsRepository implements StationStorage {
  List<Station> _stations = [];

  @override
  Future bulkAdd(List<Station> stations) async {
    _stations.addAll(stations);
  }

  @override
  Future<List<Station>> getStations() async => _stations;

  @override
  Future<List<Station>> getStationsByCountryCode(String countryCode) async {
    return _stations
        .where((element) => element.countryCode == countryCode)
        .toList();
  }

  @override
  Future<bool> isEmpty() async => _stations.isEmpty;

  @override
  Future update(Station station) async {}

  @override
  void SetActiveFiltering(bool active) {
    // TODO: implement SetActiveFiltering
  }
}

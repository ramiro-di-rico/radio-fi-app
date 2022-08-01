import 'package:radio_fi/services/controllers/station-controller.dart';
import '../../data/station.dart';
import '../http/stations-service.dart';

class SyncStationsController extends StationsController {
  StationsService _stationsRepository = StationsService();
  bool _editSearchText = false;
  List<Station> stations = [];

  StationsController() {
    _stationsRepository.loadCountryCodes();
    _stationsRepository.syncStations();
    _stationsRepository.addListener(updateStationsList);
  }

  void updateStationsList() {
    _refreshStations();
    notifyListeners();
  }

  changeTextEditState(bool value) {
    _editSearchText = value;

    if (!_editSearchText) _refreshStations();
    notifyListeners();
  }

  void setFavorite(Station station, bool star) {
    if (star) {
      _stationsRepository.star(station);
    } else {
      _stationsRepository.unstar(station);
    }
    if (!isSearching()) {
      _refreshStations();
    }
  }

  void _refreshStations() {
    stations = [];
    stations
        .addAll(_stationsRepository.stations.where((element) => element.star));
    stations
        .addAll(_stationsRepository.stations.where((element) => !element.star));
  }

  List<String> getCountryCodes() => _stationsRepository.countryCodes;

  void changeCountryCode(String countryCode) {
    _stationsRepository.changeCountryCode(countryCode);
  }

  @override
  Future<List<Station>> getStations() {
    // TODO: implement getStations
    throw UnimplementedError();
  }

  @override
  Future<List<Station>> getStationsByContryCode(String countryCode) {
    // TODO: implement getStationsByContryCode
    throw UnimplementedError();
  }
}

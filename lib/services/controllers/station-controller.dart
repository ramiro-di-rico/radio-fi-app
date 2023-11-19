import 'package:flutter/cupertino.dart';
import 'package:radio_fi/services/station-fetcher.dart';
import 'package:radio_fi/services/station-manager.dart';
import 'package:radio_fi/services/station-storage.dart';
import '../../data/station.dart';
import '../http/http-stations-service.dart';
import '../initializer.dart';
import '../repositories/supabase-stations-repository.dart';

class StationsController extends ChangeNotifier
    implements StationFetcher, StationManager, Initializer {
  HttpStationsService _httpStationsService = HttpStationsService();
  SupabaseStationsRepository _supabaseStationsRepository =
      SupabaseStationsRepository();
  String _searchText = '';
  bool _editSearchText = false;
  List<Station> stations = [];
  @protected
  List<Station> _internalStations = [];
  int _index = -1;
  late StationStorage _stationStorage;
  bool _initialized = false;
  String error = "";

  StationsController(StationStorage stationStorage) {
    _stationStorage = stationStorage;
  }

  changeTextEditState(bool value) {
    _editSearchText = value;

    if (!_editSearchText) _refreshStations();
    notifyListeners();
  }

  Iterable<Station> search(String value) {
    _searchText = value;

    if (_searchText.length > 0) {
      stations = _internalStations
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    } else {
      _refreshStations();
    }

    notifyListeners();
    return stations;
  }

  bool isSearching() => _editSearchText;

  int getDisplayedStationIndex() {
    var index = _index;
    _index = -1;
    return index;
  }

  @override
  Future<List<Station>> getStations() async {
    var stations = await _stationStorage.isEmpty() || !_initialized
        ? await _supabaseStationsRepository.getStations()
        : await _stationStorage.getStations();
    return stations;
  }

  @override
  void setFavorite(Station station, bool star) async {
    station.star = star;
    await _stationStorage.update(station);
  }

  @override
  Future initialize() async {
    var data = await getStations();
    _internalStations.addAll(data);
    await _stationStorage.bulkAdd(data);
    _initialized = true;
    _refreshStations();
  }

  void _refreshStations() {
    stations = [];
    stations.addAll(_internalStations);
    notifyListeners();
  }
}

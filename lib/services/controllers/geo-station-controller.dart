import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:radio_fi/data/station.dart';
import 'package:radio_fi/services/station-storage.dart';
import '../http/http-stations-service.dart';
import '../initializer.dart';
import '../repositories/supabase-stations-repository.dart';
import '../station-fetcher.dart';
import '../station-manager.dart';

class GeoStationsController extends ChangeNotifier
    implements GeoStationFetcher, StationManager, Initializer {
  String? _countryCode = "AR"; //CountryCodes.detailsForLocale().alpha2Code;
  HttpStationsService _httpStationsService = HttpStationsService();
  SupabaseStationsRepository _supabaseStationsRepository =
  SupabaseStationsRepository();
  late StationStorage _stationStorage;
  List<Station> _internalStations = [];
  List<Station> stations = [];
  List<String> countryCodes = [];
  String _searchText = '';
  bool _editSearchText = false;
  bool _initialized = false;
  String error = '';

  GeoStationsController(StationStorage stationStorage) {
    _stationStorage = stationStorage;
  }

  Future<List<String>> getCountryCodes() async =>
      await _httpStationsService.getCountryCodes();

  void changeCountryCode(String countryCode) {
    _countryCode = countryCode;
  }

  @override
  Future<List<Station>> getStationsByCountryCode(String countryCode) async {
    if (!await _stationStorage.isEmpty() || _initialized) {
      return await _stationStorage.getStationsByCountryCode(countryCode);
    }

    try {
      return await _supabaseStationsRepository.getStationsByCountryCode(countryCode);
    } on Exception catch (e) {
      error = e.toString();
      return [];
    }
  }

  @override
  Future initialize() async {
    var data = await getStationsByCountryCode(_countryCode!);
    _internalStations.addAll(data);
    _internalStations.sort((a, b) => b.star ? 1 : -1);
    await _stationStorage.bulkAdd(data);
    _initialized = true;
    _refreshStations();
  }

  @override
  Iterable<Station> search(String stationName) {
    _searchText = stationName;

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

  @override
  changeTextEditState(bool value) {
    _editSearchText = value;

    if (!_editSearchText) _refreshStations();
    notifyListeners();
  }

  @override
  void setFavorite(Station station, bool star) async {
    station.star = star;
    await _stationStorage.update(station);
    stations.sort((a, b) => b.star ? 1 : -1);
    notifyListeners();
  }

  void _refreshStations() {
    stations = [];
    stations.addAll(_internalStations);
    notifyListeners();
  }

  @override
  int getDisplayedStationIndex() => -1;

  @override
  bool isSearching() => _editSearchText;
}

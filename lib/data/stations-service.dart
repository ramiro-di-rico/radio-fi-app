import 'dart:convert';
import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'configurations-repository.dart';
import 'station.dart';
import 'package:http/http.dart' as http;

import 'stations-repository.dart';

class StationsService extends ChangeNotifier {
  List<Station> stations = [];
  List<String> countryCodes = [];
  List<String> starredStations = List.empty(growable: true);
  File file;
  String _countryCode = CountryCodes.detailsForLocale().alpha2Code;
  StationsRepository _stationsRepository = StationsRepository();
  ConfigurationsRepository _configurationsRepository =
      ConfigurationsRepository();

  Future syncStations() async {
    stations.clear();
    var savedStations =
        await _stationsRepository.getStations(countryCode: _countryCode);
    stations.addAll(savedStations.where((element) => element.star).toList());
    stations.addAll(savedStations.where((element) => !element.star).toList());
    var needSync = await _configurationsRepository.needSync();
    if (stations.isEmpty || needSync) {
      await _backgroundSync();
      await _configurationsRepository.updateSyncTimeStamp();
    }

    notifyListeners();
  }

  Future _backgroundSync() async {
    stations.clear();
    var endpointStations = await _getStations();
    await _stationsRepository.bulkAdd(endpointStations);
    stations = await _stationsRepository.getStations(countryCode: _countryCode);
  }

  void star(Station station) async {
    station.star = true;
    await _stationsRepository.update(station);
  }

  void unstar(Station station) async {
    station.star = false;
    await _stationsRepository.update(station);
  }

  Future<List<Station>> _getStations() async {
    var queryParameters = {'Active': 'true', 'CountryCode': _countryCode};

    var response = await http.get(Uri.https(
        "ramiro-di-rico.dev", "radioapi/api/stations", queryParameters));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      var result = data.map((e) => Station.fromJson(e)).toList();
      return result;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return List.empty();
    }
  }

  void changeCountryCode(String countryCode) async {
    _countryCode = countryCode;
    await syncStations();
  }

  Future loadCountryCodes() async {
    var response = await http.get(
        Uri.https("ramiro-di-rico.dev", "radioapi/api/stations/countryCodes"));
    List data = json.decode(response.body);
    countryCodes = data.map((e) => e.toString()).toList();
  }
}

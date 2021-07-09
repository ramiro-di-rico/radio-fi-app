import 'dart:convert';
import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'station.dart';
import 'package:http/http.dart' as http;

class StationsRepository extends ChangeNotifier {
  List<Station> stations = [];
  List<String> countryCodes = [];
  List<String> starredStations = List.empty(growable: true);
  File file;
  String _countryCode = CountryCodes.detailsForLocale().alpha2Code;

  void syncStations() async {
    file = await _loadCsvFile();
    await _loadStarredStations();
    stations.clear();
    var endpointStations = await _getStations();
    stations.addAll(endpointStations);
    for (var i = 0; i < stations.length; i++) {
      var station = stations[i];
      if (starredStations.any((element) => element == station.name)) {
        station.star = true;
      }
    }
    notifyListeners();
  }

  void star(Station station) {
    station.star = true;
    starredStations.add(station.name);
    _writeStarredStations();
  }

  void unstar(Station station) {
    if (starredStations.any((element) => element == station.name)) {
      station.star = false;
    }
    starredStations.removeWhere((element) => element == station.name);
    _writeStarredStations();
  }

  Future _loadStarredStations() async {
    if (!await file.exists()) {
      await file.create();
    }

    String contents = await file.readAsString();
    var splits = contents.split(',');
    if (contents.isNotEmpty) {
      starredStations.addAll(splits);
    }
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

  Future _writeStarredStations() async {
    var contents = starredStations.map((e) => '$e,').join();
    await file.writeAsString(contents);
  }

  Future<File> _loadCsvFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/stations.csv');
  }

  void changeCountryCode(String countryCode) {
    _countryCode = countryCode;
    syncStations();
  }

  Future loadCountryCodes() async {
    var response = await http.get(
        Uri.https("ramiro-di-rico.dev", "radioapi/api/stations/countryCodes"));
    List data = json.decode(response.body);
    countryCodes = data.map((e) => e.toString()).toList();
  }
}

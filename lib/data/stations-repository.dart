import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'station.dart';
import 'package:http/http.dart' as http;

class StationsRepository extends ChangeNotifier {
  List<Station> stations = [];
  List<String> starredStations = List.empty(growable: true);
  File file;

  void syncStations() async {
    file = await _loadCsvFile();
    await _loadStarredStations();
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
    var url = 'https://ramiro-di-rico.dev/radioapi/api/radios';

    var response = await http.get(url);
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
}

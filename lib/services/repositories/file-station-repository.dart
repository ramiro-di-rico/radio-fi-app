import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:radio_fi/data/station.dart';

import '../station-storage.dart';

class FileStationRepository implements StationStorage {
  String _filename = "stations.json";

  @override
  Future bulkAdd(List<Station> stations) async {
    await _saveJsonFile(stations);
  }

  @override
  Future<List<Station>> getStations() async {
    var stations = await _readJsonFile();
    return stations;
  }

  @override
  Future<List<Station>> getStationsByCountryCode(String countryCode) async {
    var stations = await _readJsonFile();
    return stations
        .where((element) => element.countryCode == countryCode)
        .toList();
  }

  @override
  Future<bool> isEmpty() async {
    var file = await _getJsonFile();
    return await file.exists();
  }

  @override
  Future update(Station station) async {
    var stations = await _readJsonFile();
    var toUpdate = stations.firstWhere((element) => element.id == station.id);
    toUpdate.star = station.star;
    await _saveJsonFile(stations);
  }

  Future<File> _getJsonFile() async {
    Directory tempDir = await getTemporaryDirectory();
    var path = tempDir.path + Platform.pathSeparator + _filename;
    return File(path);
  }

  Future<List<Station>> _readJsonFile() async {
    var file = await _getJsonFile();
    var jsonFile = await file.readAsString();
    List data = json.decode(jsonFile);
    var result = data.map((e) => Station.fromJson(e)).toList();
    return result;
  }

  Future _saveJsonFile(List<Station> stations) async {
    var jsonFile = jsonEncode(stations);
    var file = await _getJsonFile();
    await file.writeAsString(jsonFile, mode: FileMode.writeOnly);
  }
}

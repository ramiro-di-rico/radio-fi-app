import 'package:flutter/cupertino.dart';
import 'package:radio_fi/services/repositories/database-helper.dart';
import 'package:radio_fi/services/station-storage.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/station.dart';

class StationsRepository implements StationStorage {
  static final columnId = 'id';
  DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Station>> getStations({String countryCode}) async {
    try {
      var database = await _dbHelper.getDb();
      var query = countryCode == null
          ? 'SELECT * FROM Stations ORDER BY lower(name) ASC'
          : 'SELECT * FROM Stations WHERE countryCode = "$countryCode" ORDER BY lower(name) ASC';
      List<Map> list = await database.rawQuery(query);
      var result = list.map((e) => Station.fromJson(e)).toList();
      return result;
    } catch (e) {
      debugPrint(e);
      return List.empty();
    }
  }

  Future update(Station station) async {
    try {
      var database = await _dbHelper.getDb();
      var values = {
        'name': station.name,
        'uri': station.uri,
        'imageUrl': station.imageUrl,
        'star': station.star,
        'countryCode': station.countryCode
      };

      int updateCount = await database.update('Stations', values,
          where: '$columnId = ?', whereArgs: [station.id]);
      debugPrint('rows updated $updateCount');
    } catch (e) {
      debugPrint(e);
    }
  }

  Future add(Station station) async {
    try {
      var database = await _dbHelper.getDb();
      var values = {
        'id': station.id,
        'name': station.name,
        'uri': station.uri,
        'imageUrl': station.imageUrl,
        'star': station.star,
        'countryCode': station.countryCode
      };

      await database.insert('Stations', values,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future bulkAdd(List<Station> stations) async {
    try {
      var storedStations = await getStations();
      var database = await _dbHelper.getDb();
      var batch = database.batch();
      for (var i = 0; i < stations.length; i++) {
        var station = stations[i];
        var storedStation = storedStations.firstWhere(
            (element) => element.id == station.id,
            orElse: () => null);
        var values = {
          'id': station.id,
          'name': station.name,
          'uri': station.uri,
          'imageUrl': station.imageUrl,
          'star': storedStation != null ? storedStation.star : false,
          'countryCode': station.countryCode
        };

        batch.insert('Stations', values,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      batch.commit();
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Future<List<Station>> getStationsByCountryCode(String countryCode) async =>
      await getStations(countryCode: countryCode);

  @override
  Future<bool> isEmpty() async {
    try {
      var database = await _dbHelper.getDb();
      var query = 'SELECT COUNT(*) FROM Stations ORDER BY lower(name) ASC';
      List<Map> list = await database.rawQuery(query);
      var result = list.map((e) => Station.fromJson(e)).toList();
      return false;
    } catch (e) {
      debugPrint(e);
      return true;
    }
  }
}

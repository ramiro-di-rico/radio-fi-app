import 'package:flutter/cupertino.dart';
import 'package:radio_fi/services/repositories/database-helper.dart';
import 'package:radio_fi/services/station-storage.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/station.dart';

class StationsRepository implements StationStorage {
  static final columnId = 'id';
  DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Station>> getStations() async {
    try {
      var database = await _dbHelper.getDb();
      var query = 'SELECT * FROM Stations ORDER BY lower(name) ASC';
      List<Map> list = await database!.rawQuery(query);
      var result = list.map((e) => Station.fromJson(e)).toList();
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return List.empty();
    }
  }

  @override
  Future<List<Station>> getStationsByCountryCode(String countryCode) async {
    try {
      var database = await _dbHelper.getDb();
      var query =
          'SELECT * FROM Stations WHERE countryCode = "$countryCode" ORDER BY lower(name) ASC';
      List<Map> list = await database!.rawQuery(query);
      var result = list.map((e) => Station.fromJson(e)).toList();
      return result;
    } catch (e) {
      debugPrint(e.toString());
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

      int updateCount = await database!.update('Stations', values,
          where: '$columnId = ?', whereArgs: [station.id]);
      debugPrint('rows updated $updateCount');
    } catch (e) {
      debugPrint(e.toString());
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

      await database!.insert('Stations', values,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future bulkAdd(List<Station> stations) async {
    try {
      var storedStations = await getStations();
      var database = await _dbHelper.getDb();
      var batch = database!.batch();
      for (var i = 0; i < stations.length; i++) {
        var station = stations[i];
        var storedStation =
            storedStations.firstWhere((element) => element.id == station.id);
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
      debugPrint(e.toString());
    }
  }

  @override
  Future<bool> isEmpty() async {
    try {
      var database = await _dbHelper.getDb();
      int? count = Sqflite.firstIntValue(
          await database!.rawQuery('SELECT COUNT(*) FROM Stations'));
      return count == 0;
    } catch (e) {
      debugPrint(e.toString());
      return true;
    }
  }

  @override
  void SetActiveFiltering(bool active) {
    // TODO: implement SetActiveFiltering
  }
}

import 'package:flutter/widgets.dart';
import 'package:radio_fi/data/configuration.dart';
import 'package:sqflite/sqflite.dart';

import 'database-helper.dart';

class ConfigurationsRepository {
  DatabaseHelper _dbHelper = DatabaseHelper();
  static final String syncTimeStamp = "SyncTimeStamp";

  Future<bool> needSync() async {
    try {
      var database = await _dbHelper.getDb();
      List<Map> list = await database.rawQuery('SELECT * FROM Configurations');
      var result = list.map((e) => Configuration.fromJson(e)).toList();

      if (result.isEmpty) return true;

      var lastSync = result.firstWhere(
          (element) => element.name == ConfigurationsRepository.syncTimeStamp,
          orElse: null);

      if (lastSync == null) return true;

      var lastSyncDate = DateTime.parse(lastSync.value);
      var sync = lastSyncDate.add(Duration(days: 1));
      return sync.isBefore(DateTime.now());
    } catch (e) {
      debugPrint(e);
      return false;
    }
  }

  Future updateSyncTimeStamp() async {
    try {
      var database = await _dbHelper.getDb();
      var values = {
        'id': 1,
        'name': ConfigurationsRepository.syncTimeStamp,
        'value': DateTime.now().toString(),
      };

      await database.insert('Configurations', values,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future setFakeDate() async {
    try {
      var database = await _dbHelper.getDb();
      var values = {
        'id': 1,
        'name': ConfigurationsRepository.syncTimeStamp,
        'value': DateTime.now().subtract(Duration(days: 2)).toString(),
      };

      await database.insert('Configurations', values,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      debugPrint(e);
    }
  }
}

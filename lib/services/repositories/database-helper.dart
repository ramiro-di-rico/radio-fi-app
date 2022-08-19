import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String databasesPath = '';
  String path = '';
  Future<Database>? _db;
  static final columnId = 'id';

  Future<Database>? getDb() {
    _db ??= _initDb();
    return _db;
  }

  Future<Database>? _initDb() async {
    databasesPath = await getDatabasesPath();

    try {
      await Directory(databasesPath).create(recursive: true);

      path = join(databasesPath, "stations.db");

      final Database db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Stations (id INTEGER PRIMARY KEY, name TEXT, uri TEXT, imageUrl TEXT, countryCode TEXT, star bool)');
        await db.execute(
            'CREATE TABLE Configurations (id INTEGER PRIMARY KEY, name TEXT, value TEXT)');
      });
      return db;
    } catch (_) {
      //debugPrint(_);
      throw _;
      //return Future.value(null);
    }
  }
}

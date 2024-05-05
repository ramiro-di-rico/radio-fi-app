import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'secret_keys.dart';
import 'services/controllers/player-controller.dart';
import 'services/controllers/geo-station-controller.dart';
import 'myapp.dart';
import 'services/controllers/station-controller.dart';
import 'services/repositories/in-memory-stations-repository.dart';
import 'services/repositories/stations-repository.dart';
import 'services/station-manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS) {
    await CountryCodes.init();
    var controller = GeoStationsController(StationsRepository());
    controller.initialize();
    GetIt.instance.registerSingleton<StationManager>(controller);
  } else {
    var controller = StationsController(InMemoryStationsRepository());
    controller.initialize();
    GetIt.instance.registerSingleton<StationManager>(controller);
  }
  GetIt.instance.registerSingleton(PlayerController());

  runApp(new MyApp());
}
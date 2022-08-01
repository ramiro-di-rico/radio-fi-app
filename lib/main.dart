import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'services/controllers/sync-station-controller.dart';
import 'myapp.dart';
import 'services/controllers/station-controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS) {
    await CountryCodes.init();
    var controller = SyncStationsController();
    GetIt.instance.registerSingleton(controller);
  } else {
    var controller = StationsController();
    GetIt.instance.registerSingleton(controller);
  }

  runApp(new MyApp());
}

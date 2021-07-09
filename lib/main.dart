import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'myapp.dart';
import 'data/station-controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();
  var controller = StationsController();
  GetIt.instance.registerSingleton(controller);

  runApp(new MyApp());
}

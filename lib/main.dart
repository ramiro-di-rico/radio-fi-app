import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'myapp.dart';
import 'data/station-controller.dart';

void main() {
  var controller = StationsController();
  GetIt.instance.registerSingleton(controller);
  
  runApp(new MyApp());
}


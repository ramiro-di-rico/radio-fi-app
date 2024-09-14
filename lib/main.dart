import 'package:flutter/material.dart';
import 'myapp.dart';
import 'services/platforms/platform_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var platform = PlatformStrategy.createPlatform();
  await platform.initialize();

  runApp(new MyApp());
}
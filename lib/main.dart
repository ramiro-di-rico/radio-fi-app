import 'package:flutter/material.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'myapp.dart';
import 'services/platforms/platform_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  JustAudioMediaKit.ensureInitialized(
    linux: true,
    windows: false,
  );

  var platform = PlatformStrategy.createPlatform();
  await platform.initialize();

  runApp(new MyApp(platform));
}
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'main-screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesktopApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<DesktopApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        themeMode: ThemeMode.system,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        routes: {MainScreen.id: (context) => MainScreen()},
        initialRoute: MainScreen.id,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ]);
  }
}

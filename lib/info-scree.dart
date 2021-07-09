import 'package:flutter/material.dart';
import 'controls/app-info.dart';
import 'controls/country-code-selector.dart';

class InfoScreen extends StatefulWidget {
  static const String id = 'info_screen';

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Radio App"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CountryCodeSelector(),
              AppInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

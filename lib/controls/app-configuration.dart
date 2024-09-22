import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/station-fetcher.dart';
import '../services/station-manager.dart';

class AppConfiguration extends StatefulWidget {

  @override
  State<AppConfiguration> createState() => _AppConfigurationState();
}

class _AppConfigurationState extends State<AppConfiguration> {

  StationViewManager _stationFetcher = GetIt.instance<StationViewManager>();
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Text('Active filtering'),
          trailing: Switch(
            value: isActive,
            onChanged: (value) {
              setState(() {
                isActive = value;
                var stationFetcher = _stationFetcher as GeoStationFetcher;
                stationFetcher.SetActiveFiltering(value);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        )
      ],
    );
  }
}

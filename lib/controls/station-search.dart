import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_fi/data/station-controller.dart';

class StationSearchWidget extends StatefulWidget {
  @override
  _StationSearchWidgetState createState() => _StationSearchWidgetState();
}

class _StationSearchWidgetState extends State<StationSearchWidget> {
  StationsController _stationsController = GetIt.instance<StationsController>();
  String currentText = '';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        onChanged: (text) {
          currentText = text;
          _stationsController.search(text);
        },
        decoration: InputDecoration(
            hintText: 'Hint Text',
            suffixIcon: IconButton(
                icon: Icon(Icons.check),
                onPressed: currentText.length > 0
                    ? () => _stationsController.changeTextEditState(false)
                    : null)),
      ),
    );
  }
}

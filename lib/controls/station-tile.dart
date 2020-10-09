import 'package:flutter/material.dart';

class StationText extends Text {
  final String stationTitle;
  final bool isPlaying;

  StationText({@required this.stationTitle, @required this.isPlaying}) : super(stationTitle);

  @override
  TextStyle get style => TextStyle(color: isPlaying ? Colors.greenAccent : null);
}

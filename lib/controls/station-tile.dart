import 'package:flutter/material.dart';

class StationText extends Text {
  final String stationTitle;
  final bool isPlaying;
  final bool star;

  StationText(
      {@required this.stationTitle,
      @required this.isPlaying,
      @required this.star})
      : super(stationTitle);

  @override
  TextStyle get style => TextStyle(
      color: isPlaying
          ? Colors.blue[400]
          : star
              ? Colors.black
              : Colors.white);
}

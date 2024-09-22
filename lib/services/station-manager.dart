import 'package:flutter/cupertino.dart';

import '../data/station.dart';

abstract class StationViewManager extends ChangeNotifier {
  Iterable<Station> search(String stationName);
  bool isSearching();
  void setFavorite(Station station, bool star);
  void changeTextEditState(bool value);
  late List<Station> stations;
  int getDisplayedStationIndex();
  String error = "";
}

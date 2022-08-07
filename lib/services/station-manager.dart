import 'package:flutter/cupertino.dart';

import '../data/station.dart';

abstract class StationManager extends ChangeNotifier {
  Iterable<Station> search(String stationName);
  bool isSearching();
  void setFavorite(Station station, bool star);
  void changeTextEditState(bool value);
  List<Station> stations;
  int getDisplayedStationIndex();
}

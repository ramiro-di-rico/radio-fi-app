import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'station.dart';
import 'package:http/http.dart' as http;

class StationsRepository extends ChangeNotifier{

  List<Station> stations = [];

  void syncStations() async {
    var url = 'http://206.189.239.38:5910/api/radios';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      var result = data.map((e) => Station.fromJson(e)).toList();
      
      stations.addAll(result);
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
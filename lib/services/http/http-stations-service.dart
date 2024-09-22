import 'dart:convert';
import 'package:radio_fi/data/station.dart';
import 'package:radio_fi/services/station-fetcher.dart';
import 'package:http/http.dart' as http;

class HttpStationsService implements StationFetcher, GeoStationFetcher {
  @override
  Future<List<Station>> getStations() async {
    return await getStationsByCountryCode("");
  }

  @override
  Future<List<Station>> getStationsByCountryCode(String countryCode) async {
    var queryParameters = {'Active': 'true', 'CountryCode': countryCode};

    var response = await http.get(Uri.https(
        "www.ramiro-di-rico.dev", "radioapi/api/stations", queryParameters));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      var result = data.map((e) => Station.fromJson(e)).toList();
      return result;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return List.empty();
    }
  }

  Future<List<String>> getCountryCodes() async {
    var response = await http.get(
        Uri.https("www.ramiro-di-rico.dev", "radioapi/api/stations/countryCodes"));
    List data = json.decode(response.body);
    return data.map((e) => e.toString()).toList();
  }

  @override
  void SetActiveFiltering(bool active) {
    // TODO: implement SetActiveFiltering
  }
}

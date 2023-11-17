import 'package:radio_fi/data/station.dart';

import '../../main.dart';
import '../station-fetcher.dart';

class SupabaseStationsRepository implements StationFetcher, GeoStationFetcher {

  @override
  Future<List<Station>> getStations() async {
    return await getStationsByCountryCode("AR");
  }

  @override
  Future<List<Station>> getStationsByCountryCode(String countryCode) async {
    List<dynamic> data = await supabase
        .from('Stations')
        .select('*')
        .eq('CountryCode', countryCode);

    var result = data.map((e) => Station.fromSupabase(e)).toList();

    return result;
  }
}
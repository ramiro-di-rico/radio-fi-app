import 'package:country_codes/country_codes.dart';
import 'package:get_it/get_it.dart';

import '../controllers/geo-station-controller.dart';
import '../controllers/player-controller.dart';
import '../repositories/stations-repository.dart';
import '../station-manager.dart';
import 'platform_context.dart';
import 'platform_type.dart';

class MobilePlatform extends PlatformContext {
  @override
  Future initialize() async {
    await CountryCodes.init();
    var controller = GeoStationsController(StationsRepository());
    controller.initialize();
    GetIt.instance.registerSingleton<StationViewManager>(controller);
    GetIt.instance.registerSingleton(PlayerController());
  }

  @override
  PlatformType getPlatformType() {
    return PlatformType.Mobile;
  }
}
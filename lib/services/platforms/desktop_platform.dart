import 'package:get_it/get_it.dart';

import '../controllers/player-controller.dart';
import '../controllers/station-controller.dart';
import '../repositories/in-memory-stations-repository.dart';
import '../station-manager.dart';
import 'platform_context.dart';
import 'platform_type.dart';

class DesktopPlatform extends PlatformContext {
  @override
  Future initialize() async {
    var controller = StationsController(InMemoryStationsRepository());
    controller.initialize();
    GetIt.instance.registerSingleton<StationViewManager>(controller);
    GetIt.instance.registerSingleton(PlayerController());
  }

  @override
  PlatformType getPlatformType() {
    return PlatformType.Desktop;
  }
}
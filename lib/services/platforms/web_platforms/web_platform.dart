import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/player-controller.dart';
import '../../controllers/station-controller.dart';
import '../../repositories/in-memory-stations-repository.dart';
import '../../station-manager.dart';
import 'base_web_platform.dart';
import '../platform_context.dart';
import '../platform_type.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

class WebPlatform extends BaseWebPlatformContext{
  PlatformContext createWebPlatform() {
    return WebPlatformImpl();
  }
}

class WebPlatformImpl extends PlatformContext {
  @override
  Future initialize() async {
    usePathUrlStrategy();

    var controller = StationsController(InMemoryStationsRepository());
    controller.initialize();
    GetIt.instance.registerSingleton<StationViewManager>(controller);
    GetIt.instance.registerSingleton(PlayerController());
  }

  @override
  PlatformType getPlatformType() {
    if (context == null) {
      return PlatformType.Web;
    }

    var screenSize = MediaQuery
        .of(context!)
        .size;
    var isDesktop = screenSize.width > 720;

    return isDesktop ? PlatformType.Web : PlatformType.WebMobile;
  }
}
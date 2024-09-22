import 'package:flutter/widgets.dart';

import '../platform_context.dart';
import '../platform_type.dart';
import 'base_web_platform.dart';

class WebPlatform extends BaseWebPlatformContext{
  PlatformContext createWebPlatform() {
    return NoneWebPlatformImpl();
  }
}

class NoneWebPlatformImpl implements PlatformContext {

  @override
  BuildContext? context;

  @override
  PlatformType getPlatformType() {
    // TODO: implement getPlatformType
    throw UnimplementedError();
  }

  @override
  Future initialize() async {
    // TODO: implement initialize
  }

  @override
  void setContext(BuildContext buildingContext) {
    // TODO: implement setContext
  }

  @override
  bool isDarkMode() {
    // TODO: implement isDarkMode
    throw UnimplementedError();
  }
}
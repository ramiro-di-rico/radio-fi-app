import 'package:flutter/widgets.dart';

import 'platform_type.dart';

abstract class PlatformContext{
  BuildContext? context;

  void setContext(BuildContext buildingContext) {
    context = buildingContext;
  }

  Future initialize();

  PlatformType getPlatformType();
}
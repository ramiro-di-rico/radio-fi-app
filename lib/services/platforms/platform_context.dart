import 'package:flutter/material.dart';

import 'platform_type.dart';

abstract class PlatformContext{
  BuildContext? context;

  void setContext(BuildContext buildingContext) {
    context = buildingContext;
  }

  Future initialize();

  PlatformType getPlatformType();

  bool isDarkMode() {
    return Theme.of(context!).brightness == Brightness.dark;
  }
}
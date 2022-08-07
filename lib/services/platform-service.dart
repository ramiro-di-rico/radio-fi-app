import 'dart:io';

class PlatformService {
  bool isSupported() => Platform.isAndroid || Platform.isIOS;
}

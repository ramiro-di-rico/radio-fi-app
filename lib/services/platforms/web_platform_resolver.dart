import 'platform_context.dart';
import 'web_platforms/web_platform.dart';

class WebPlatformResolver {
  WebPlatform _webPlatform = WebPlatform();

  PlatformContext getWebPlatform(){
    return _webPlatform.createWebPlatform();
  }
}
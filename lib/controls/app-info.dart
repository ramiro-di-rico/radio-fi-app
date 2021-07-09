import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppInfoWidget extends StatefulWidget {
  @override
  _AppInfoWidgetState createState() => _AppInfoWidgetState();
}

class _AppInfoWidgetState extends State<AppInfoWidget> {
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";
  bool infoLoaded = false;

  Future _getBuildInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      infoLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getBuildInfo();
    return Card(
      child: infoLoaded
          ? Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "Application Information",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text("App name : $appName"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text("Package: $packageName"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text("Version: $version"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text("Build number $buildNumber"),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          : CircularProgressIndicator(),
    );
  }
}

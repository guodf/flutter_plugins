import 'package:common_path_provider/common_path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PathProvider.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    print(await PathProvider.getPublicPath(DirectoryType.alarms));
    print(await PathProvider.getPublicPath(DirectoryType.cache));
    print(await PathProvider.getPublicPath(DirectoryType.dcim));
    print(await PathProvider.getPublicPath(DirectoryType.documents));
    print(await PathProvider.getPublicPath(DirectoryType.download));
    print(await PathProvider.getPublicPath(DirectoryType.home));
    print(await PathProvider.getPublicPath(DirectoryType.movies));
    print(await PathProvider.getPublicPath(DirectoryType.music));
    print(await PathProvider.getPublicPath(DirectoryType.pictures));
    print(await PathProvider.appPathProvider.appPath);
    print(await PathProvider.appPathProvider.appCachePath);
    print(await PathProvider.appPathProvider.appDataPath);
    print(await PathProvider.appPathProvider.appFilesPath);

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            FlatButton(child: Text("getHome"), onPressed: () {
              PathProvider.getPublicPath(DirectoryType.music);
            },)
          ],
        ),
      ),
    );
  }
}

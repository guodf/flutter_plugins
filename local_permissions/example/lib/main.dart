import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:local_permissions/local_permissions.dart';
import 'package:local_permissions/manifest.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text(Permissions.READ_EXTERNAL_STORAGE),
              onTap: () async {
                var agrees = await LocalPermissions.getPermissions(
                    [Permissions.READ_EXTERNAL_STORAGE]);
                print([Permissions.READ_EXTERNAL_STORAGE, agrees]);
              },
            ),
            ListTile(
              title: Text("CAMERA"),
              onTap: () async {
                var agrees = await LocalPermissions.getPermissions([
                  Permissions.READ_EXTERNAL_STORAGE,
                  Permissions.CAMERA
                ]);
                print([Permissions.CAMERA, agrees]);
              },
            )
          ],
        ),
      ),
    );
  }
}

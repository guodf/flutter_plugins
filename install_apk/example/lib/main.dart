import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:install_apk/install_apk.dart';
import 'package:local_permissions/local_permissions.dart';
import 'package:local_permissions/manifest.dart' as manifest;
import 'package:common_path_provider/common_path_provider.dart';
import 'package:download_manager/download_manager.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        body: Center(
          child: RaisedButton(
            child: Text("download and install apk"),
            onPressed: () async {
            },
          ),
        ),
      ),
    );
  }
}

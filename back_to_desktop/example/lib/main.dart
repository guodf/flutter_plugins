import 'dart:math';

import 'package:flutter/material.dart';
import 'package:back_to_desktop/back_to_desktop.dart';

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
    var random = Random().nextInt(10);
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          await BackToDesktop.backToDesktop();
          //important
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Plugin example app'),
          ),
          body: Center(
            child: Text('Random:$random'),
          ),
        ),
      ),
    );
  }
}

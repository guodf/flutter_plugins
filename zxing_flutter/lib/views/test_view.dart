import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: AndroidView(viewType: "zxing_flutter.myView",)
    );
  }
}
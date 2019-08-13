import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zxing_flutter/views/scanner_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _result="点击开始扫描";
  bool _isComplete=false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:_isComplete? Container(
          alignment:Alignment.center,
          child:InkWell(
            onTap: (){
              _isComplete=false;
              setState(() {
                
              });
            },
            child: Text(_result),
          ),
        )
        :ScannerView((result){
          setState(() {
            _result=result;
            _isComplete=true;
          });
        }),
      )
    );
  }
}

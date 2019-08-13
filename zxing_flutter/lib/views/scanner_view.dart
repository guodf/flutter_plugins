import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnScannerCallback = Function(String result);

class ScannerView extends StatefulWidget {
  OnScannerCallback onScannerCallback;
  ScannerView(this.onScannerCallback) :assert(onScannerCallback!=null);
  
  @override
  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:Alignment.center,
      child: AndroidView(      
          viewType: "zxing_flutter.scannerView",
          onPlatformViewCreated: (id) async{
            var channel=MethodChannel("zxing_flutter.scannerView_$id");
            String result = await channel.invokeMethod("scanner");
            widget.onScannerCallback(result);
          },
        ),
    );
  }
}
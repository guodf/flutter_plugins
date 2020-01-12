import 'dart:async';

import 'package:flutter/services.dart';

class DownloadManager {
  static const MethodChannel _channel =
      const MethodChannel('guo.top.flutter.download_manager');

  static Future<String> get platformVersion async {
    return "top.guodf.flutter.download_manager";
  }

  static Future<int> download(String url,{String title}) async{
    return await _channel.invokeMethod("download",[url,title]);
  }

  static Future<bool> cancel(String downloadId)async{
    return await _channel.invokeMethod("cancel",downloadId);
  }
}

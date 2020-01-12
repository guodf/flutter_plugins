import 'dart:async';

import 'package:flutter/services.dart';

class InstallApk {
  static const MethodChannel _channel =
      const MethodChannel('guo.top.flutter.install_apk');

  static Future<bool> installApk(String filePath) async {
    return await _channel.invokeMethod('installApk',filePath);
  }
}
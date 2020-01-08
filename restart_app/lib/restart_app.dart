import 'dart:async';

import 'package:flutter/services.dart';

class RestartApp {
  static const MethodChannel _channel = const MethodChannel('restart_app');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> restartFull() async {
    await _channel.invokeMethod("restartFull");
  }

  static Future<void> restartFast() async {
    await _channel.invokeMethod("restartFast");
  }
}

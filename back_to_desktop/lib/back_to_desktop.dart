import 'dart:async';

import 'package:flutter/services.dart';

class BackToDesktop {
  static const MethodChannel _channel =
      const MethodChannel('back_to_desktop');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

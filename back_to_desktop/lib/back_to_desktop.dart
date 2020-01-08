import 'dart:async';

import 'package:flutter/services.dart';

class BackToDesktop {
  static const MethodChannel _channel =
      const MethodChannel('guo.top.flutter.back_to_desktop');

  // call android activity.moveTaskToBack(false)
  static Future<bool> backToDesktop() async{
    return await _channel.invokeMethod("backToDesktop");
  }
}


import 'dart:async';

import 'package:flutter/services.dart';

class MediaView {
  static const MethodChannel _channel =
      const MethodChannel('media_view');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

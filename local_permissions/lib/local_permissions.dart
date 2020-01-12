import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

class LocalPermissions {
  static const MethodChannel _channel =
      const MethodChannel('guo.top.flutter.local_permissions');
  static List<String> _hasPermissions = [];

  static Future<List<String>> getPermissions(List<String> permissions) async {
    if(!Platform.isAndroid){
      throw UnimplementedError();
    }
    var hasPermissions = <String>[];
    var noPermissions = permissions.where((permission) {
      if (_hasPermissions.contains(permission)) {
        hasPermissions.add(permission);
        return false;
      }
      return true;
    }).toList();
    if (noPermissions.length > 0) {
      var agrees = (await _channel.invokeMethod('getPermissions', noPermissions))as List<dynamic>;
      for(var item in agrees){
        hasPermissions.add(item as String);
      }
    }
    return hasPermissions;
  }
}

import 'dart:core';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryType{
  static const home="Home";
  static const music="Music";
  static const alarms="Alarms"; 
  static const pictures="Pictures";
  static const movies="Movies";
  static const download="Download";
  static const dcim="DCIM";
  static const documents="documents";
  static const cache="Cache";
}

class PathProvider {
  static const MethodChannel _channel =
      MethodChannel('common_path_provider');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> getPublicPath(String directoryType) async {
    return await _channel.invokeMethod('getPublicPath',directoryType);
  }

  static const CurrentAppPathProvider appPathProvider =CurrentAppPathProvider(_channel);
}

class CurrentAppPathProvider {
  final MethodChannel _channel;
  const CurrentAppPathProvider(this._channel);

  Future<String> get appPath async {
    var dir = await getApplicationSupportDirectory();
    return dir.parent.absolute.path;
  }

  Future<String> get appCachePath async {
    var directory = await getTemporaryDirectory();
    return directory?.path;
  }

  Future<String> get appFilesPath async {
    var dir = await getApplicationSupportDirectory();
    return dir.path;
  }

  Future<String> get appDataPath async {
    var dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  // Future<List<String>> get appExternalPath async {
  //   return await _channel.invokeMethod("appExternalPath");
  // }

  // Future<List<String>> get _appExternalCachePath async {
  //   return null;
  // }

  // Future<List<String>> get _externalAppFilesPath async {
  //   return null;
  // }

  // Future<List<String>> get _externalAppDataPath async {
  //   return null;
  // }
}

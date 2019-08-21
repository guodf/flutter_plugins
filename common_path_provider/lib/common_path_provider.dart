import 'dart:core';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// 目录类型

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

/// 获取常用目录类
class PathProvider {
  static const MethodChannel _channel =
      MethodChannel('common_path_provider');

  /// 获取android版本

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 根据DirectoryType获取目录路径
  /// 
  /// call Environment.getDataDirectory().absolutePat if DirectoryType.Home
  /// 
  /// call Environment.getDownloadCacheDirectory().absolutePath if Directory.Home 
  /// 
  /// call Environment.getExternalStoragePublicDirectory(type) else other
  static Future<String> getPublicPath(String directoryType) async {
    return await _channel.invokeMethod('getPublicPath',directoryType);
  }

  /// 获取当前app的目录路径
  static const CurrentAppPathProvider appPathProvider =CurrentAppPathProvider(_channel);
}

class CurrentAppPathProvider {
  final MethodChannel _channel;
  const CurrentAppPathProvider(this._channel);

  /// 获取app根目录
  Future<String> get appPath async {
    var dir = await getApplicationSupportDirectory();
    return dir.parent.absolute.path;
  }

  /// 获取app的cache目录
  Future<String> get appCachePath async {
    var directory = await getTemporaryDirectory();
    return directory?.path;
  }

  /// 获取app的files目录
  Future<String> get appFilesPath async {
    var dir = await getApplicationSupportDirectory();
    return dir.path;
  }

  /// 获取app的data目录:app_flutter
  Future<String> get appDataPath async {
    var dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  /// 获取app外部存储路径
  Future<String> get appExternalPath async {
    return await _channel.invokeMethod("appExternalPath");
  }

  /// 获取app外部[DirectoryType]对应的目录
  Future<String> appExternalPublicPath(String directoryType) async{
    return await _channel.invokeMethod("appExternalPublicPath",directoryType);
  }

  /// 获取app外部cache目录
  Future<String> get appExternalCachePath async {
    return await _channel.invokeMethod("appExternalCachePath");
  }

  /// 获取app外部files目录
  Future<String> get appExternalFilesPath async {
    return await _channel.invokeMethod("appExternalFilesPath");
  }
}

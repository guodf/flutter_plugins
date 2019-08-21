import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:media_store/models/album_info.dart';
import 'package:media_store/models/media_info.dart';
import 'package:media_store/models/serializer.dart';

class MediaStore {
  static const MethodChannel _channel = const MethodChannel('media_store');

  static Future<String> get cacheDirPath async {
    return await _channel.invokeMethod('getCacheDir');
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List<MediaInfo>> getAllMediaList() async {
    var medias = List<MediaInfo>();
    final result = await _channel.invokeMethod("getAllMediaList");
    for (var item in jsonDecode(result)) {
      medias.add(serializers.deserializeWith(MediaInfo.serializer, item));
    }
    return medias;
  }

  static Future<List<dynamic>> getAlbumInfoList() async {
    var albums = List<AlbumInfo>();

    final result = await _channel.invokeMethod("getAlbumInfoList");
    for (var item in jsonDecode(result)) {
      albums.add(serializers.deserializeWith(AlbumInfo.serializer, item));
    }
    return albums;
  }

  static Future<Uint8List> getImageByGlide(String filePath) async {
    var result = await _channel.invokeMethod('getImageByGlide', filePath);
    if (result is Uint8List) {
      return result;
    } else if (result is List<dynamic>) {
      List<int> l = result.map((v) {
        if (v is int) {
          return v;
        }
        return 0;
      }).toList();
      return Uint8List.fromList(l);
    }
    return null;
  }

  static Future<Uint8List> getImageByFresco(String filePath) async {
    var result = await _channel.invokeMethod('getImageByFresco', filePath);
    if (result is Uint8List) {
      return result;
    } else if (result is List<dynamic>) {
      List<int> l = result.map((v) {
        if (v is int) {
          return v;
        }
        return 0;
      }).toList();
      return Uint8List.fromList(l);
    }
    return null;
  }

  static Future<String> getImageThumbnail(String filePath,String outFilePath) async {
    try {
      if(await File(outFilePath).exists()){
        return outFilePath;
      }
      var methodName=path.equals(path.extension(filePath),".mp4")? "createVideoThumbnail":"createImageThumbnail";
      if(await _channel.invokeMethod(methodName, [filePath, outFilePath])){
        return outFilePath;
      }
    }
    catch (e) {
      print(e);
      return outFilePath;
    }
    return outFilePath;
  }
}

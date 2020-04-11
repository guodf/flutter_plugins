import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dart_utils/date_util.dart';
import 'package:dart_utils/logger_util.dart';
import 'package:dart_utils/version_util.dart';
import 'package:device_info/device_info.dart';
import 'package:download_manager/download_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:install_apk/install_apk.dart';
import 'package:package_info/package_info.dart';

class AppUpdate {
  static const MethodChannel _channel = const MethodChannel('app_update');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Timer _timer;

  static bool _updateing = false;

  static Future check(String url) async {
    try {
      if (_updateing) {
        Logger.info("已存在进行中的升级任务...");
        return;
      }
      _updateing = true;
      final packInfo = await PackageInfo.fromPlatform();
      final oldVersion = packInfo.version;
      var resp = await http.get("$url/version/check");
      if (resp.statusCode == HttpStatus.ok) {
//      {
//        "version":"",
//        "name":"",
//        "appId":"",
//        "armeabi-v7a":"",
//        "arm64-v8a":"",
//        "x86_64":"",
//      }
        var map = json.decode(resp.body) as Map<String, dynamic>;
        if (VersionUtil.compare(map["version"], oldVersion) > 0) {
          final android = await DeviceInfoPlugin().androidInfo;
          final cpu = android.supportedAbis.first;
          final downloadId =
              await DownloadManager.download(map[cpu], title: map["name"]);
          // 获取下载状态，并安装
          _timer = Timer.periodic(Duration(seconds: 2), (timer) {
            DownloadManager.status(downloadId).then((status) {
              Logger.info(["download", downloadId, status].toString());
              if (status == (1 << 3)) {
                if (!_timer.isActive) {
                  return;
                }
                _timer?.cancel();
                DownloadManager.filePath(downloadId).then((filePath) {
                  Logger.info(["install apk", filePath].toString());
                  if(filePath!=null) {
                    InstallApk.installApk(filePath).then((value){
                      Logger.info("安装结果:$value");
                    });
                  }
                  _reset();
                });
              }
            });
          });
        }
      }
    } catch (e) {
      Logger.error(e.toString());
      _reset();
    }
  }

  static _reset() {
    _updateing = false;
    _timer = null;
  }
}

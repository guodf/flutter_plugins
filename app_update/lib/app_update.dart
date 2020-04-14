import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_utils/logger_util.dart';
import 'package:dart_utils/version_util.dart';
import 'package:device_info/device_info.dart';
import 'package:download_manager/download_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:install_apk/install_apk.dart';
import 'package:package_info/package_info.dart';

class AppUpdate {
  static const MethodChannel _channel = const MethodChannel('app_update');

  Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  BuildContext context;
  Timer _timer;

  bool _updateing = false;

  Future check(String url) async {
    try {
      if (_updateing) {
        return;
      }
      _updateing = true;
      final packInfo = await PackageInfo.fromPlatform();
      final oldVersion = packInfo.version;
      var resp = await http.get("$url/last/version/${packInfo.packageName}");
      if (resp.statusCode == HttpStatus.ok) {
        var map = json.decode(resp.body) as Map<String, dynamic>;
        if (map["code"] == 10000) {
          var data = map["data"];
          if (VersionUtil.compare(data["version"]["version"], oldVersion) > 0) {
            final android = await DeviceInfoPlugin().androidInfo;
            final cpu = android.supportedAbis.first?.replaceAll("-", "_");

            var fileUrl = data["files"]
                ?.firstWhere((item) => item["cpu"] == cpu)["file"] as String;

            if (fileUrl == null || fileUrl.isEmpty) {
              fileUrl = data["files"]
                      ?.firstWhere((item) => item["cpu"] == "all")["file"]
                  as String;
            }
            if (fileUrl != null && fileUrl.length > 0) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(
                        "更新提醒",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            "发现新版本是否立即更新?",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: FlatButton(
                                child: Text("残忍拒绝"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: FlatButton(
                                child: Text("立即更新"),
                                onPressed: () {
                                  _update(fileUrl,packInfo.appName);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            }
            // });
          }
        }
      }
    } catch (e) {
      Logger.error(e.toString());
      _reset();
    }
  }

  _update(String downUrl,String name) async{
    final downloadId =
        await DownloadManager.download(downUrl, title: name);
    // 获取下载状态，并安装
    // _timer = Timer.periodic(Duration(seconds: 2), (timer) {
    DownloadManager.status(downloadId).then((status) {
      if (status == (1 << 3)) {
        if (!_timer.isActive) {
          return;
        }
        _timer?.cancel();
        DownloadManager.filePath(downloadId).then((filePath) {
          if (filePath != null) {
            InstallApk.installApk(filePath).then((value) {});
          }
          _reset();
        });
      }
    });
  }

  _reset() {
    _updateing = false;
    _timer = null;
  }

  AppUpdate.of(this.context);
}

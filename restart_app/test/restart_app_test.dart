import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restart_app/restart_app.dart';

void main() {
  const MethodChannel channel = MethodChannel('restart_app');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await RestartApp.platformVersion, '42');
  });
}

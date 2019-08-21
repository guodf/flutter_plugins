import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_path_provider/path_provider.dart';

void main() {
  const MethodChannel channel = MethodChannel('common_path_provider');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PathProvider.platformVersion, '42');
  });
  
}

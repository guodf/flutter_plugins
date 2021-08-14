import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_store/media_store.dart';

void main() {
  const MethodChannel channel = MethodChannel('media_store');

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
    expect(await MediaStore.platformVersion, '42');
  });
}

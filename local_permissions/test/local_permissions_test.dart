import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_permissions/local_permissions.dart';

void main() {
  const MethodChannel channel = MethodChannel('local_permissions');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}

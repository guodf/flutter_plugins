#import "ZxingFlutterPlugin.h"
#import <zxing_flutter/zxing_flutter-Swift.h>

@implementation ZxingFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZxingFlutterPlugin registerWithRegistrar:registrar];
}
@end

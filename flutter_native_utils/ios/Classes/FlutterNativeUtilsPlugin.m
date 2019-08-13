#import "FlutterNativeUtilsPlugin.h"
#import <flutter_native_utils/flutter_native_utils-Swift.h>

@implementation FlutterNativeUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNativeUtilsPlugin registerWithRegistrar:registrar];
}
@end

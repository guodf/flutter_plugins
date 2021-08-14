#import "AoaSdkPlugin.h"
#if __has_include(<aoa_sdk/aoa_sdk-Swift.h>)
#import <aoa_sdk/aoa_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "aoa_sdk-Swift.h"
#endif

@implementation AoaSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAoaSdkPlugin registerWithRegistrar:registrar];
}
@end

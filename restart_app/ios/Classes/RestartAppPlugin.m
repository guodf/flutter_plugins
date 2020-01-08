#import "RestartAppPlugin.h"
#if __has_include(<restart_app/restart_app-Swift.h>)
#import <restart_app/restart_app-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "restart_app-Swift.h"
#endif

@implementation RestartAppPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRestartAppPlugin registerWithRegistrar:registrar];
}
@end

#import "LocalPermissionsPlugin.h"
#if __has_include(<local_permissions/local_permissions-Swift.h>)
#import <local_permissions/local_permissions-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "local_permissions-Swift.h"
#endif

@implementation LocalPermissionsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLocalPermissionsPlugin registerWithRegistrar:registrar];
}
@end

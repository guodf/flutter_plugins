#import "BackToDesktopPlugin.h"
#if __has_include(<back_to_desktop/back_to_desktop-Swift.h>)
#import <back_to_desktop/back_to_desktop-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "back_to_desktop-Swift.h"
#endif

@implementation BackToDesktopPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBackToDesktopPlugin registerWithRegistrar:registrar];
}
@end

#import "MediaViewPlugin.h"
#if __has_include(<media_view/media_view-Swift.h>)
#import <media_view/media_view-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "media_view-Swift.h"
#endif

@implementation MediaViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMediaViewPlugin registerWithRegistrar:registrar];
}
@end

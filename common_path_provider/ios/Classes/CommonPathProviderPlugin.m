#import "CommonPathProviderPlugin.h"
#if __has_include(<common_path_provider/common_path_provider-Swift.h>)
#import <common_path_provider/common_path_provider-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "common_path_provider-Swift.h"
#endif

@implementation CommonPathProviderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCommonPathProviderPlugin registerWithRegistrar:registrar];
}
@end

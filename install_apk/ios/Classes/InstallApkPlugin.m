#import "InstallApkPlugin.h"
#if __has_include(<install_apk/install_apk-Swift.h>)
#import <install_apk/install_apk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "install_apk-Swift.h"
#endif

@implementation InstallApkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInstallApkPlugin registerWithRegistrar:registrar];
}
@end

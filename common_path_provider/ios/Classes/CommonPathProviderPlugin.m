#import "CommonPathProviderPlugin.h"
#import <common_path_provider/common_path_provider-Swift.h>

@implementation CommonPathProviderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCommonPathProviderPlugin registerWithRegistrar:registrar];
}
@end

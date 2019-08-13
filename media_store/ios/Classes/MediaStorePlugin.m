#import "MediaStorePlugin.h"
#import <media_store/media_store-Swift.h>

@implementation MediaStorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMediaStorePlugin registerWithRegistrar:registrar];
}
@end

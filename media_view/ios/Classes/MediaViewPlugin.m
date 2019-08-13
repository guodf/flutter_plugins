#import "MediaViewPlugin.h"
#import <media_view/media_view-Swift.h>

@implementation MediaViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMediaViewPlugin registerWithRegistrar:registrar];
}
@end

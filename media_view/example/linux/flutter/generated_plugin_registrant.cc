//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <media_view/media_view_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) media_view_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MediaViewPlugin");
  media_view_plugin_register_with_registrar(media_view_registrar);
}

package top.guodf.common_path_provider

import android.media.audiofx.EnvironmentalReverb
import android.os.Build
import android.os.Environment
import android.provider.ContactsContract
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class CommonPathProviderPlugin(val registrar: Registrar): MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {

      val channel = MethodChannel(registrar.messenger(), "common_path_provider")
      channel.setMethodCallHandler(CommonPathProviderPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${Build.VERSION.RELEASE}")
      }
      "getPublicPath"->{
        when(call.arguments<String>()){
          "Home"->{
            result.success(Environment.getDataDirectory().absolutePath)
          }
          "Cache"->{
            result.success(Environment.getDownloadCacheDirectory().absolutePath)
          }else->{
            result.success(Environment.getExternalStoragePublicDirectory(call.arguments<String>()).absolutePath)
          }
        }
      }
      "appExternalPath"->{
        var path=registrar.context().getExternalFilesDir(null)?.parent
        result.success(path)
      }
      "appExternalPublicPath"->{
        result.success(registrar.context().getExternalFilesDir(call.arguments<String>())?.absolutePath)
      }
      "appExternalCachePath"->{
        result.success(registrar.context().externalCacheDir?.absolutePath)
      }
      "appExternalFilesPath"->{
        result.success(registrar.context().getExternalFilesDir(null)?.absolutePath)
      }
      else -> {
        result.notImplemented()
      }
    }
  }
}

package top.guodf.common_path_provider

import android.os.Build
import android.os.Environment
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
        if(Build.VERSION.SDK_INT>=19) {
          result.success(registrar.context().getExternalFilesDirs(null))
        }else{
          var paths= arrayListOf<String>()
          var extPath=registrar.context().getExternalFilesDir(null)
          for (file in Environment.getExternalStoragePublicDirectory(Environment.MEDIA_MOUNTED).parent) {

          }
          result.success(paths);
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }
}

package top.guodf.flutter.common_path_provider

import android.content.Context
import android.os.Build
import android.os.Environment
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** CommonPathProviderPlugin */
public class CommonPathProviderPlugin: FlutterPlugin, MethodCallHandler {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    setMethodCallHandler(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val commonPathProviderPlugin = CommonPathProviderPlugin()
      commonPathProviderPlugin.setMethodCallHandler(registrar.context(), registrar.messenger());
    }
  }
  private lateinit var _context: Context
  fun setMethodCallHandler(context: Context, binaryMessenger: BinaryMessenger) {
    _context=context
    var channel = MethodChannel(binaryMessenger, "guo.top.flutter.common_path_provider")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${Build.VERSION.RELEASE}")
      }
      "getPublicPath" -> {
        when (call.arguments<String>()) {
          "Home" -> {
            result.success(Environment.getDataDirectory().absolutePath)
          }
          "Cache" -> {
            result.success(Environment.getDownloadCacheDirectory().absolutePath)
          }
          else -> {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.FROYO) {
              result.success(Environment.getExternalStoragePublicDirectory(call.arguments<String>()).absolutePath)
            }
          }
        }
      }
      "appExternalPath" -> {
        var path = _context.getExternalFilesDir(null)?.parent
        result.success(path)
      }
      "appExternalPublicPath" -> {
        result.success(_context.getExternalFilesDir(call.arguments<String>())?.absolutePath)
      }
      "appExternalCachePath" -> {
        result.success(_context.externalCacheDir?.absolutePath)
      }
      "appExternalFilesPath" -> {
        result.success(_context.getExternalFilesDir(null)?.absolutePath)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }
}

package top.guodf.flutter.install_apk

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File


/** InstallApkPlugin */
public class InstallApkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    setMethodCallHandler(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
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
      var installApkPlugin = InstallApkPlugin();
      installApkPlugin.setMethodCallHandler(registrar.context(), registrar.messenger())
    }
  }

  private lateinit var _context: Context
  private lateinit var _channel: MethodChannel
  private lateinit var _activity: Activity
  private fun setMethodCallHandler(context: Context, binaryMessenger: BinaryMessenger) {
    _context = context
    _channel = MethodChannel(binaryMessenger, "guo.top.flutter.install_apk")
    _channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    _channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
//    _activity.finish()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    _activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity();
  }


  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "installApk") {
      var filePath=call.arguments as String
      if (!filePath.isNullOrEmpty()) {
        try {
          val intent = Intent(Intent.ACTION_INSTALL_PACKAGE)
          intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
          intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
          var file=File(filePath)
          if(file.exists()) {
            var uri = Uri.fromFile(file)
            intent.setDataAndType(uri, "application/vnd.android.package-archive")
            _activity.startActivity(intent)
            result.success(true)
            return
          }
          result.success(false)
        }catch (e:Exception){
          print(e)
          result.success(false)
        }
      }
      result.success(false)
    } else {
      result.notImplemented()
    }
  }
}

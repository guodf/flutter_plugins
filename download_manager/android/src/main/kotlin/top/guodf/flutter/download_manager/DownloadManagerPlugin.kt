package top.guodf.flutter.download_manager

import android.app.Activity
import android.app.DownloadManager
import android.content.Context
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** DownloadManagerPlugin */
public class DownloadManagerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
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
      var plugin = DownloadManagerPlugin();
      plugin.setMethodCallHandler(registrar.context(), registrar.messenger())
    }
  }

  private lateinit var _context: Context
  private lateinit var _channel: MethodChannel
  private lateinit var _activity: Activity
  private fun setMethodCallHandler(context: Context, binaryMessenger: BinaryMessenger) {
    _context = context
    _channel = MethodChannel(binaryMessenger, "guo.top.flutter.download_manager")
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
    if (call.method == "download") {
      var downloadManager = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD) {
        var args = call.arguments as ArrayList<String>
        var request = DownloadManager.Request(Uri.parse(args.get(0)))
        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
        request.setTitle(args.get(1))
        var downloadManager = _context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
        var downloadId = downloadManager.enqueue(request)
        result.success(downloadId)
      } else {
        TODO("VERSION.SDK_INT < GINGERBREAD")
      }
      result.success(0)
    } else if (call.method == "cancel") {
      var downloadManager = _context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
      var downloadId=downloadManager.remove(call.arguments as Long)
      result.success(downloadId)
    } else {
      result.notImplemented()
    }
  }
}

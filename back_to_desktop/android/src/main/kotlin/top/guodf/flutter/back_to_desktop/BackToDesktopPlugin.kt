package top.guodf.flutter.back_to_desktop

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull;
import androidx.annotation.Nullable
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** BackToDesktopPlugin */
public class BackToDesktopPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
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
            val backToDesktopPlugin = BackToDesktopPlugin()
            backToDesktopPlugin.setMethodCallHandler(registrar.context(), registrar.messenger());
        }
    }

    private lateinit var _context: Context
    private var _channel: MethodChannel? = null
    private var _activity: Activity? = null
    fun setMethodCallHandler(context: Context, binaryMessenger: BinaryMessenger) {
        _context = context
        _channel = MethodChannel(binaryMessenger, "guo.top.flutter.back_to_desktop")
        _channel?.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "backToDesktop") {
            if (_activity != null) {
                _activity?.moveTaskToBack(false)
                result.success(true);
            } else {
                result.success(false)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        _channel?.setMethodCallHandler(null)
        _channel = null
    }

    override fun onDetachedFromActivity() {
        _activity = null
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
}

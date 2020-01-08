package top.guodf.restart_app


import android.app.*
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager

import android.os.Build
import android.os.Process

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.*
import kotlin.system.exitProcess

/** RestartAppPlugin */
public class RestartAppPlugin : FlutterPlugin, MethodCallHandler {
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
            val restartAppPlugin = RestartAppPlugin();
            restartAppPlugin.onAttachedToEngine(registrar.context(), registrar.messenger());
        }
    }

    private lateinit var _context: Context
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
    }

    fun onAttachedToEngine(context: Context, binaryMessenger: BinaryMessenger) {
        _context = context;
        val channel = MethodChannel(binaryMessenger, "restart_app")
        channel.setMethodCallHandler(this);
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "restartFull") {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.CUPCAKE) {
                var intent = _context.packageManager.getLaunchIntentForPackage(_context.packageName.toString())
                val restartIntent: PendingIntent = PendingIntent.getActivity(_context, 0, intent, PendingIntent.FLAG_ONE_SHOT);
                val mgr = _context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
                mgr.set(AlarmManager.RTC, System.currentTimeMillis()+100, restartIntent);
                exitProcess(0);
            }
        } else if (call.method == "restartFast") {
            // 无效果
            var intent = _context.packageManager.getLaunchIntentForPackage(_context.packageName.toString())
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
//            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            _context.startActivity(intent)
            Process.killProcess(Process.myPid());
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }
}

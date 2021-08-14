package top.guodf.flutter.local_permissions

import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

// 我的权限验证码
const val MY_PERMISSION_CODE = 99099

/** LocalPermissionsPlugin */
public class LocalPermissionsPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.RequestPermissionsResultListener {
  private lateinit var _context: Context
  private lateinit var _channel: MethodChannel
  private lateinit var _activity: Activity
  private lateinit var _result: Result
  private lateinit var _agreePermissionsList: ArrayList<String>

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    _context = flutterPluginBinding.applicationContext
    _channel = MethodChannel(flutterPluginBinding.binaryMessenger, "guo.top.flutter.local_permissions")
    _channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    _result = result
    if (call.method == "getPermissions") {
      _agreePermissionsList = arrayListOf()

      var permissionsList = call.arguments as ArrayList<String>
      if (permissionsList.count() == 0) {
        _result.success(_agreePermissionsList)
        return
      }

      var noPermissionList = arrayListOf<String>()
      for (permission in permissionsList) {
        if (ActivityCompat.checkSelfPermission(_context, permission) != PackageManager.PERMISSION_GRANTED) {
          noPermissionList.add(permission)
          //sdk>=23有效 如果用之前拒绝过则返回true，如果用户勾选了不在询问则返回false
//              if(ActivityCompat.shouldShowRequestPermissionRationale(_activity,permission)){
//                println("")
//              }
        } else {
          _agreePermissionsList.add(permission);
        }
      }
      if (noPermissionList.count() == 0) {
        _result.success(_agreePermissionsList)
        return
      }
      var permissionsArr = noPermissionList.toTypedArray<String>()
      ActivityCompat.requestPermissions(_activity, permissionsArr, MY_PERMISSION_CODE)
    } else {
      result.notImplemented()
    }
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
    binding.removeRequestPermissionsResultListener(this);
    binding.addRequestPermissionsResultListener(this);
    _activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity();
  }

  override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>?, grantResults: IntArray?): Boolean {
    try {
      if (requestCode == MY_PERMISSION_CODE) {
        permissions?.forEachIndexed { index, permission ->
          if (grantResults?.get(index) == PackageManager.PERMISSION_GRANTED) {
            _agreePermissionsList.add(permission)
          }
        }
      }
      _result?.success(_agreePermissionsList)
      return false;
    } catch (e: Exception) {
      print(e);
    }
    return false
  }
}

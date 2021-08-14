package top.guodf.flutter.media_store

import android.Manifest
import android.app.Activity
import androidx.annotation.NonNull
import com.facebook.cache.disk.DiskCacheConfig
import com.google.gson.Gson
import io.flutter.embedding.engine.FlutterEngine

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MediaStorePlugin */
class MediaStorePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var mediaManager: MediaManager
    private lateinit var permissionManager: PermissionManager
    private lateinit var glideUtil: GlideUtil
    private lateinit var diskCacheConfig: DiskCacheConfig

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "media_store")
        channel.setMethodCallHandler(this)
        mediaManager = MediaManager(flutterPluginBinding)
        glideUtil = GlideUtil(flutterPluginBinding.applicationContext)
        diskCacheConfig =
            DiskCacheConfig.newBuilder(flutterPluginBinding.applicationContext).build()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        permissionManager.requestPermission(arrayListOf(
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE,
            Manifest.permission.INTERNET,
            Manifest.permission.CAMERA
        ), object : IPermissionListener {
            override fun completed(isOK: Boolean) {
                if (isOK) {
                    when (call.method) {
                        "getPlatformVersion" -> {
                            result.success("Android ${android.os.Build.VERSION.RELEASE}")
                        }
                        "getAlbumInfoList" -> {
                            val list = mediaManager.getAlbumInfoList()
                            val jsonStr = Gson().toJson(list)
                            result.success(jsonStr)
                        }
                        "getAllMediaList" -> {
                            val list = mediaManager.getAllMediaList()
                            val jsonStr = Gson().toJson(list)
                            result.success(jsonStr)
                        }
                        "getImageByFresco" -> {
                            val filePath = call.arguments as String
                            FrescoUtil.getImage(filePath, result)
                        }

                        "getImageByGlide" -> {
                            glideUtil.getImage(call.arguments as String, result)
                        }

                        "createImageThumbnail" -> {
                            val args = call.arguments as List<String>
                            mediaManager.createImageThumbnail(args[0], args[1], result)
                        }
                        "createVideoThumbnail" -> {
                            val args = call.arguments as List<String>
                            mediaManager.createVideoThumbnail(args[0], args[1], result)
                        }
                        "getCacheDir" -> {
                            val path = mediaManager.getCacheDir()
                            result.success(path)
                        }
                        else -> {
                            result.notImplemented()
                        }
                    }
                }
            }
        })
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        permissionManager = PermissionManager(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}

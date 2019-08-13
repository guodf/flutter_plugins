package top.guodf.mediastore

import android.Manifest
import com.facebook.cache.disk.DiskCacheConfig
import com.facebook.drawee.backends.pipeline.Fresco
import com.facebook.imagepipeline.core.ImagePipelineConfig
import com.google.gson.Gson
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class MediaStorePlugin(registrar: Registrar) : MethodCallHandler {

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "media_store")
            channel.setMethodCallHandler(MediaStorePlugin(registrar))
            val diskCacheConfig=DiskCacheConfig
                    .newBuilder(registrar.context())
                    .build()

//            val config= ImagePipelineConfig
//                    .newBuilder(registrar.context())
//                    .setDiskCacheEnabled(true)
//                    .setDownsampleEnabled(true)
//                    .setMainDiskCacheConfig(diskCacheConfig)
//                    .build()
//
//            Fresco.initialize(registrar.context(),config)
        }
    }

    private var mediaManager: MediaManager = MediaManager(registrar)
    private val permissionManager:PermissionManager= PermissionManager(registrar)
    private var glideUtil:GlideUtil= GlideUtil(registrar.context())

    override fun onMethodCall(call: MethodCall, result: Result) {
        permissionManager.requestPermission(arrayListOf(
                Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.INTERNET,
                Manifest.permission.CAMERA
        ),object:IPermissionListener{
            override fun completed(isOK: Boolean) {
                if(isOK){
                    when (call.method) {
                        "getPlatformVersion" -> {
                            result.success("Android ${android.os.Build.VERSION.RELEASE}")
                        }
                        "getAlbumInfoList" -> {
                            val list = mediaManager.getAlbumInfoList()
                            val jsonStr=Gson().toJson(list)
                            result.success(jsonStr)
                        }
                        "getAllMediaList" -> {
                            val list = mediaManager.getAllMediaList()
                            val jsonStr=Gson().toJson(list)
                            result.success(jsonStr)
                        }
                        "getImageByFresco"->{
                            val filePath=call.arguments as String
                            FrescoUtil.getImage(filePath,result)
                        }

                        "getImageByGlide"->{
                            glideUtil.getImage(call.arguments as String,result)
                        }

                        "createImageThumbnail"->{
                            val args=call.arguments as List<String>
                            mediaManager.createImageThumbnail(args[0],args[1],result)
                        }
                        "createVideoThumbnail"-> {
                            val args = call.arguments as List<String>
                            mediaManager.createVideoThumbnail(args[0], args[1], result)
                        }
                        "getCacheDir"->{
                            val path=mediaManager.getCacheDir()
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
}
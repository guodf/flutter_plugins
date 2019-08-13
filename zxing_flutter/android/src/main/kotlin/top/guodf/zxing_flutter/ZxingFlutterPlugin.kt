package top.guodf.zxing_flutter

import android.Manifest
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.platform.PlatformViewFactory
import java.util.*

class ZxingFlutterPlugin {

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val platfromViewRegistry = registrar
                    .platformViewRegistry()
            platfromViewRegistry
                    .registerViewFactory(MyViewFactory.viewName, MyViewFactory(registrar.messenger()))
            platfromViewRegistry
                    .registerViewFactory(ScannerViewFactory.viewName,ScannerViewFactory(registrar.messenger()))
        }
    }

    private fun permission(){
//        Manifest.permission.CAMERA
//        Manifest.permission.INTERNET1
        Manifest.permission.CAMERA
    }
}

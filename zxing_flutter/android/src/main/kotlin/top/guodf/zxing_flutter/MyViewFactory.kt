package top.guodf.zxing_flutter

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.BinaryMessenger as BinaryMessenger1

class MyViewFactory(private val messenger: BinaryMessenger1) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    companion object {
        @JvmStatic var viewName="zxing_flutter.myView"
    }
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        return  MyView(context,this.messenger)
    }
}
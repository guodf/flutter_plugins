package top.guodf.zxing_flutter

import android.view.View
import io.flutter.plugin.platform.PlatformView
import android.widget.TextView
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger

class MyView(context: Context,messenger: BinaryMessenger) : PlatformView {
    private val myNativeView: TextView
    private var text="hello"
    init {
        val myNativeView = TextView(context)
        myNativeView.text=this.text

        this.myNativeView = myNativeView
    }

    override fun getView(): View {
        return myNativeView
    }

    override fun dispose() {

    }
}
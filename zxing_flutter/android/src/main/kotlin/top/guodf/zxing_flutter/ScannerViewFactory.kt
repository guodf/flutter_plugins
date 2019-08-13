package top.guodf.zxing_flutter

import android.content.Context
import android.graphics.PointF
import android.hardware.camera2.CameraManager
import android.os.Parcel
import android.os.Parcelable
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

import com.dlazaro66.qrcodereaderview.QRCodeReaderView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class ScannerViewFactory(private var binaryMessenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    companion object{
        @JvmStatic var viewName="zxing_flutter.scannerView"
    }

    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        return ScannerView(context,binaryMessenger,id,args)
    }
}

class ScannerView(context: Context, messenger: BinaryMessenger, id: Int, args: Any?) : PlatformView, MethodCallHandler,QRCodeReaderView.OnQRCodeReadListener {

    private val qrCodeReaderView:QRCodeReaderView = QRCodeReaderView(context)
    private val channel:MethodChannel= MethodChannel(messenger,"zxing_flutter.scannerView_$id")
    private lateinit var result: MethodChannel.Result
    private var isComplete:Boolean=false
    init {
        initQRCodeReaderView()
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if(call.method == "scanner"){
            this.result=result
        }else{
            result.notImplemented()
        }
    }

    override fun onQRCodeRead(text: String?, points: Array<out PointF>?) {
        if(!isComplete) {
            isComplete=true
            result.success(text)
        }
    }

    private fun initQRCodeReaderView(){
        qrCodeReaderView.setOnQRCodeReadListener(this)
        qrCodeReaderView.setQRDecodingEnabled(true)
        qrCodeReaderView.setAutofocusInterval(2000L)
        qrCodeReaderView.setBackCamera()
//        qrCodeReaderView.setTorchEnabled(true)
        qrCodeReaderView.startCamera()
    }

    override fun getView(): View {
        return qrCodeReaderView
    }

    override fun dispose() {
        qrCodeReaderView.stopCamera()
    }
}
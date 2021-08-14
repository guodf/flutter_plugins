package top.guodf.flutter_plugins.aoa_sdk

import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.hardware.usb.UsbConstants
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import android.os.Handler
import android.os.HandlerThread
import android.os.Looper
import android.os.Message
import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.lang.Exception


class AoaSdk(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {


    private var MANUFACTURER_NAME = "AoA Test MA";
    private var MODEL_NAME = "AOA Test Model";
    private var DESCRIPTION = "Description";
    private var VERSION = "ver1.0";
    private var URI = "http://www.downloadapk.com";
    private var SERIAL = "111111111111111111";

    private val REQUEST_PERMISSION_ACTION = "com.test.usb"
    private var binding: FlutterPlugin.FlutterPluginBinding = flutterPluginBinding
    var usbManager: UsbManager? =
        binding.applicationContext.getSystemService(Context.USB_SERVICE) as UsbManager
    private var mPendingIntent: PendingIntent? = null
    private var usbHandler: UsbHandler? = null

    private val mHandlerThread = HandlerThread("usb-handler")
    fun printInfo() {
        mHandlerThread.start()
        usbHandler = UsbHandler(this, mHandlerThread.looper)

        val intentFilter: IntentFilter = IntentFilter()
        intentFilter.addAction(UsbManager.ACTION_USB_DEVICE_ATTACHED)
        intentFilter.addAction(UsbManager.ACTION_USB_ACCESSORY_DETACHED)
        intentFilter.addAction(REQUEST_PERMISSION_ACTION)
        binding.applicationContext.registerReceiver(object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                var action: String? = intent?.action
                var device: UsbDevice? =
                    intent?.getParcelableExtra<UsbDevice>(UsbManager.EXTRA_DEVICE)
                var msg = usbHandler!!.obtainMessage()
                msg.obj = device
                if (action.equals(UsbManager.ACTION_USB_DEVICE_ATTACHED)) {
                    msg.what = UsbHandler.MSG_USB_ATTACHED
                } else if (action.equals(UsbManager.ACTION_USB_ACCESSORY_DETACHED)) {
                    msg.what = UsbHandler.MSG_USB_DETACHED
                } else if (action.equals(REQUEST_PERMISSION_ACTION)) {
                    msg.what = UsbHandler.MSG_REQUEST_PERMISSION
                }
                usbHandler!!.sendMessage(msg)
            }
        }, intentFilter)

        mPendingIntent = PendingIntent.getBroadcast(
            binding.applicationContext,
            0,
            Intent(REQUEST_PERMISSION_ACTION),
            0
        )

    }

    fun switchToAoAMode(usbDevice: UsbDevice) {
        if (usbDevice.getVendorId() == 0x18D1 && (usbDevice.getProductId() == 0x2D00 ||
                    usbDevice.getProductId() == 0x2D01 ||
                    usbDevice.getProductId() == 0x2D02 ||
                    usbDevice.getProductId() == 0x2D03 ||
                    usbDevice.getProductId() == 0x2D04 ||
                    usbDevice.getProductId() == 0x2D05)
        ) {
            //UsbDevice in AOA mode.
            sendAccessoryInfo(usbDevice);
        } else {
            var udc = usbManager!!.openDevice(usbDevice);
            val datas = ByteArray(2)
            var b: Byte = 1
            var ret = udc.controlTransfer(UsbConstants.USB_DIR_IN, 51, 0, 0, datas, 1, 0);

            if (ret > 0 && datas[1] == b) {
                //device has been switch to support AOA
                sendAccessoryInfo(usbDevice);
            } else {
                //device not support AOA
            }
        }
    }

    fun sendAccessoryInfo(usbDevice: UsbDevice) {
        var udc = usbManager!!.openDevice(usbDevice);
        var ret = -1;
        try {
            var datas = MANUFACTURER_NAME.toByteArray()
            ret = udc.controlTransfer(UsbConstants.USB_DIR_OUT, 52, 0, 0, datas, datas.size, 0);
            if (ret < 0) {
                return;
            }
            datas = MODEL_NAME.toByteArray()
            ret = udc.controlTransfer(UsbConstants.USB_DIR_OUT, 52, 0, 1, datas, datas.size, 0);
            if (ret < 0) {
                return;
            }
            datas = DESCRIPTION.toByteArray()
            ret = udc.controlTransfer(UsbConstants.USB_DIR_OUT, 52, 0, 2, datas, datas.size, 0);
            if (ret < 0) {
                return;
            }
            datas = VERSION.toByteArray()
            ret = udc.controlTransfer(UsbConstants.USB_DIR_OUT, 52, 0, 3, datas, datas.size, 0);
            if (ret < 0) {
                return;
            }
            datas = URI.toByteArray()
            ret = udc.controlTransfer(UsbConstants.USB_DIR_OUT, 52, 0, 4, datas, datas.size, 0);
            if (ret < 0) {
                return;
            }
            datas = SERIAL.toByteArray()
            ret = udc.controlTransfer(UsbConstants.USB_DIR_OUT, 52, 0, 5, datas, datas.size, 0);
            if (ret < 0) {
                return;
            }
            //After send info ok, we start up accessory.
            udc.controlTransfer(UsbConstants.USB_DIR_OUT, 53, 0, 0, null, 0, 0);
        } catch (e: Exception) {
            println(e)
        }
    }

}

class UsbHandler(sdk: AoaSdk, looper: Looper) : Handler(looper) {
    companion object {
        var MSG_REQUEST_PERMISSION = 0
        var MSG_USB_ATTACHED = 1
        var MSG_USB_DETACHED = 2
    }


    private var sdk: AoaSdk = sdk

    override fun handleMessage(msg: Message) {
        super.handleMessage(msg)
        var what = msg.what
        var device = msg.obj as UsbDevice

        when (what) {
            MSG_REQUEST_PERMISSION ->
                if (sdk.usbManager!!.hasPermission(device)) {
                    sdk.switchToAoAMode(device)
                }
        }
    }
}


package top.guodf.flutter.mediastore

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import io.flutter.plugin.common.PluginRegistry

interface IPermissionListener{
    fun completed(isOK:Boolean)
}
class PermissionManager(private val registrar: PluginRegistry.Registrar){
    val permissions= arrayListOf<String>()
    var permissionListener: IPermissionListener? = null
    init {
        registrar.addRequestPermissionsResultListener(MyRequestPermissionsResultListener(this))
    }
    fun checkPermissions(permissionArr: List<String>): Boolean {
        return permissionArr.filter {
            permissions.contains(it)
        }.count()==permissionArr.count()
    }

    fun requestPermission(permissionArr:List<String>,permissionListener:IPermissionListener){
        this.permissionListener=permissionListener
        if(!checkPermissions(permissionArr)){
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    registrar.activity().requestPermissions(permissionArr.toTypedArray(),3001)
            }
        }else{
            this.permissionListener?.completed(true)
        }
    }
}

class MyRequestPermissionsResultListener(private val permissionManager:PermissionManager): PluginRegistry.RequestPermissionsResultListener {
    override fun onRequestPermissionsResult(requestCode: Int, permissionArr: Array<out String>, grantResults: IntArray): Boolean {
        for (index:Int in permissionArr.indices){
            if(grantResults[0]==PackageManager.PERMISSION_GRANTED){
                permissionManager.permissions.add(permissionArr[index])
            }
        }
        permissionManager.permissionListener?.completed(permissionManager.checkPermissions(permissionArr.toList()))
        return false
    }
}
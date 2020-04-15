package top.guodf.flutter.mediastore

import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Environment
import com.bumptech.glide.Glide
import com.bumptech.glide.GlideBuilder
import com.bumptech.glide.annotation.GlideModule
import com.bumptech.glide.disklrucache.DiskLruCache
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.load.engine.cache.DiskCache
import com.bumptech.glide.load.engine.cache.DiskLruCacheFactory
import com.bumptech.glide.module.AppGlideModule
import com.bumptech.glide.request.Request
import com.bumptech.glide.request.RequestOptions
import com.bumptech.glide.request.target.SizeReadyCallback
import com.bumptech.glide.request.target.Target
import com.bumptech.glide.request.transition.Transition
import com.bumptech.glide.signature.ObjectKey
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.InputStream
import java.io.InputStreamReader
import java.security.Signature
import java.util.*

@GlideModule
class MyAppGlideModule: AppGlideModule(){
    override fun applyOptions(context: Context, builder: GlideBuilder) {
        super.applyOptions(context, builder)
        val path=Environment.getExternalStorageDirectory()
        val factory=DiskCache.Factory {
            DiskLruCacheFactory(path.absolutePath,"1111111",1024*1024*200).build()
        }
        builder.setDiskCache(factory)
    }
}

class GlideUtil(private val context: Context) {
    var index=0
    fun getImage(filePath:String, result:MethodChannel.Result){
        GlideApp.with(context)
                .asBitmap()
                .load(filePath)
                .into(CustomerTarget(result))
    }
}

  class CustomerTarget(private val result: MethodChannel.Result) :Target<Bitmap>{
      private var request: Request? = null

      override fun onLoadStarted(placeholder: Drawable?) {

      }

      override fun onLoadFailed(errorDrawable: Drawable?) {
      }

      override fun getRequest(): Request? {
        return this.request;
      }

      override fun onStop() {

      }

      override fun setRequest(request: Request?) {
         this.request=request
      }

      override fun removeCallback(cb: SizeReadyCallback) {

      }

      override fun onLoadCleared(placeholder: Drawable?) {
      }

      override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
          val bytes = ByteArrayOutputStream()
          resource.compress(Bitmap.CompressFormat.JPEG, 100, bytes)
          result.success(bytes.toByteArray())
      }

      override fun onStart() {

      }

      override fun onDestroy() {

      }

      override fun getSize(cb: SizeReadyCallback) {
         cb.onSizeReady(300, 300)
     }
}
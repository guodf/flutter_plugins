package top.guodf.mediastore

import android.graphics.Bitmap
import android.net.Uri
import com.facebook.binaryresource.BinaryResource
import com.facebook.binaryresource.FileBinaryResource
import com.facebook.cache.common.SimpleCacheKey
import com.facebook.common.references.CloseableReference
import com.facebook.datasource.DataSource
import com.facebook.drawee.backends.pipeline.Fresco
import com.facebook.imagepipeline.cache.BufferedDiskCache
import com.facebook.imagepipeline.common.ResizeOptions
import com.facebook.imagepipeline.datasource.BaseBitmapReferenceDataSubscriber
import com.facebook.imagepipeline.image.CloseableImage
import com.facebook.imagepipeline.request.ImageRequest
import com.facebook.imagepipeline.request.ImageRequestBuilder
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.io.File
import java.util.concurrent.Executors

class BaseBitmapReferenceDataSubscriberTemp(private val result: MethodChannel.Result) : BaseBitmapReferenceDataSubscriber(){

    override fun onFailureImpl(dataSource: DataSource<CloseableReference<CloseableImage>>?) {
        dataSource?.close()
    }

    override fun onNewResultImpl(bitmapReference: CloseableReference<Bitmap>?) {
        val bitmap=bitmapReference?.get()
        if(bitmap!=null) {
            ByteArrayOutputStream().use {
                bitmap.compress(Bitmap.CompressFormat.JPEG,50,it)
                result.success(it.toByteArray())
            }
        }else{
            result.success(null)
        }
    }
}

object FrescoUtil{
    fun getImage(filePath:String,result:MethodChannel.Result){
        //var isExists=Fresco.getImagePipeline().evictFromCache(Uri.parse(filePath))
        val imagePipe=Fresco.getImagePipeline()
        val request=ImageRequestBuilder
                .newBuilderWithSource(Uri.parse(filePath))
                .setResizeOptions(ResizeOptions(200,200))
                .setLocalThumbnailPreviewsEnabled(true)
                .build()
        val dataSource=imagePipe.fetchDecodedImage(request,this)
        dataSource.subscribe(BaseBitmapReferenceDataSubscriberTemp(result),Executors.newSingleThreadExecutor())
    }
}
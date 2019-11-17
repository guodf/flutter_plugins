package top.guodf.mediastore

import android.database.Cursor
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.media.ExifInterface
import android.media.ThumbnailUtils
import android.net.Uri
import android.os.Environment
import android.provider.MediaStore
import androidx.annotation.IntDef
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.ByteArrayOutputStream
import java.io.File

class MediaManager(private val registrar: Registrar) {

    /***
     * get Albums
     */
    fun getAlbumInfoList(): List<AlbumInfo> {
        val columns = arrayOf(
                MediaStore.Images.ImageColumns.BUCKET_ID,   //MediaStore.Video.VideoColumns.BUCKET_ID
                MediaStore.Images.ImageColumns.BUCKET_DISPLAY_NAME, //MediaStore.Videos.VideoColumns.BUCKET_DISPLAY_NAME
                MediaStore.MediaColumns.DATA
        )
        val albumsMap = mutableMapOf<String, AlbumInfo>()
        arrayOf(Image, Video).forEach { mediaType ->
            this.mediaQuery(columns, mediaType, false, null, MediaStore.Images.ImageColumns.BUCKET_ID, fun(cursor) {
                val albumId = cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.BUCKET_ID))
                if (albumsMap.keys.contains(albumId)) {
                    return
                }
                val albumName = cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.BUCKET_DISPLAY_NAME))
                val uri = cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA))

                albumsMap[albumId] = AlbumInfo(albumId, albumName, uri)
            })
        }
        return albumsMap.values.sortedBy { it.id }
    }

    /**
     * get Medias (MediaTye.Video or MediaType.Image)
     */
    fun getAllMediaList(): List<MediaInfo> {
        val contentResolver = registrar.context().contentResolver
        val imageList = mutableMapOf<String, MediaInfo>()
        val videoList = mutableMapOf<String, MediaInfo>()
        val removeList = arrayListOf<Array<Any>>()
        var columns =arrayOf(
                MediaStore.MediaColumns._ID,
                MediaStore.MediaColumns.DISPLAY_NAME,
                MediaStore.Images.ImageColumns.DATE_TAKEN,
                MediaStore.MediaColumns.DATE_ADDED,
                MediaStore.MediaColumns.DATE_MODIFIED,
                MediaStore.MediaColumns.DATA,
                MediaStore.MediaColumns.MIME_TYPE,
                MediaStore.MediaColumns.SIZE,
                MediaStore.MediaColumns.WIDTH,
                MediaStore.MediaColumns.HEIGHT,
                MediaStore.Images.ImageColumns.BUCKET_ID,
                MediaStore.Images.ImageColumns.BUCKET_DISPLAY_NAME
        )
        arrayOf(Image, Video).forEach { mediaType ->
            if(mediaType==Video){
                columns=columns.plus(MediaStore.Video.VideoColumns.DURATION)
            }
            this.mediaQuery(columns, mediaType, false, null, MediaStore.MediaColumns.DATE_ADDED, fun(cursor) {
                val id = cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns._ID))
                val name = cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.DISPLAY_NAME))
                val date = cursor.getLong(cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATE_TAKEN))
                var addDate = cursor.getLong(cursor.getColumnIndex(MediaStore.MediaColumns.DATE_ADDED))
                var modifyDate = cursor.getLong(cursor.getColumnIndex(MediaStore.MediaColumns.DATE_MODIFIED))
                val path = cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA))
                val mimeType = cursor.getString(cursor.getColumnIndex(MediaStore.Images.Media.MIME_TYPE))
                val size = cursor.getLong(cursor.getColumnIndex(MediaStore.MediaColumns.SIZE))
                val width=cursor.getInt(cursor.getColumnIndex(MediaStore.MediaColumns.WIDTH))
                val height=cursor.getInt(cursor.getColumnIndex(MediaStore.MediaColumns.HEIGHT))
                var duration: Int? = null
                if(mediaType==Video){
                    duration=cursor.getInt(cursor.getColumnIndex(MediaStore.Video.VideoColumns.DURATION))
                }
                var albumId = cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.BUCKET_ID))
                var albumName = cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.BUCKET_DISPLAY_NAME))
                val media = MediaInfo(id, name, date, addDate, modifyDate, path, null, mimeType, mediaType, size,width,height,duration, albumId, albumName)

                registrar.context().contentResolver
                if (path != null && (File(path).exists())) {
                    if (mediaType == Image) {
                        imageList[id] = media
                    } else {
                        videoList[id] = media
                    }
                }
                return
            })
        }
        arrayOf(Image, Video).forEach { mediaType ->
            val mediaId = if (mediaType == Image) MediaStore.Images.Thumbnails.IMAGE_ID else MediaStore.Video.Thumbnails.VIDEO_ID
            this.mediaQuery(arrayOf(
                    mediaId,
                    MediaStore.MediaColumns.DATA
            ), mediaType, true, mediaId, null, fun(cursor) {
                try {
                    //callback(cursor)
                    val id = cursor.getString(cursor.getColumnIndex(mediaId))
                    val path = cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA))
                    if (path != null && File(path).exists()) {
                        val isContent = Uri.parse(path).scheme == "content"
                        if (isContent) {
                            return
                        }
                        when (mediaType) {
                            Image -> {
                                if (imageList.containsKey(id)) {
                                    imageList[id]?.thumUri = path
                                }
                            }
                            Video -> {
                                if (videoList.containsKey(id)) {
                                    videoList[id]?.thumUri = path
                                }
                            }
                            else -> {
                            }
                        }
                    }
                    //removeList.add(arrayOf(MediaStore.Images.Media.EXTERNAL_CONTENT_URI,MediaStore.Images.Media.DATA,path)
                } finally {
                }
            })
        }
        val list = arrayListOf<MediaInfo>()
        list.addAll(imageList.values)
        list.addAll(videoList.values)

    //    removeList.forEach {
    //        contentResolver.delete(it[0] as Uri, it[1] as String + "=?", arrayOf(it[2] as String))
    //    }

//        val options = BitmapFactory.Options();
//        options.inJustDecodeBounds=true;
//        list.forEach {
//            if (it.thumUri == null) {
//                print("uri:${it.uri}")

//                val bitMap = if (it.mediaType == MediaType.Video) {
// //                    MediaStore.Video.Thumbnails.getThumbnail(contentResolver,it.id.toLong(),MediaStore.Video.Thumbnails.MICRO_KIND,null)
//                    MediaStore.Video.Thumbnails.getThumbnail(contentResolver,it.id.toLong(),MediaStore.Video.Thumbnails.MICRO_KIND,options)

//                } else {
// //                    MediaStore.Images.Thumbnails.getThumbnail(contentResolver,it.id.toLong(),MediaStore.Images.Thumbnails.MICRO_KIND,null)
//                    MediaStore.Images.Thumbnails.getThumbnail(contentResolver,it.id.toLong(),MediaStore.Images.Thumbnails.MINI_KIND,options)
//                }
//            }
//        }
        return list.sortedBy { it.addDate }
    }

    private fun mediaQuery(columns: Array<String>, @MediaType mediaType: Int, isThumbnails: Boolean, where: String?, sortOrder: String?, callback: (cursor: Cursor) -> Unit) {
        val contentResolver = registrar.context().contentResolver
        val mediaUri: Uri
        when (mediaType) {
            Image -> {
                mediaUri = if (isThumbnails) {
                    MediaStore.Images.Thumbnails.EXTERNAL_CONTENT_URI
                } else {
                    MediaStore.Images.Media.EXTERNAL_CONTENT_URI
                }
            }
            Video -> {
                mediaUri = if (isThumbnails) {
                    MediaStore.Video.Thumbnails.EXTERNAL_CONTENT_URI
                } else {
                    MediaStore.Video.Media.EXTERNAL_CONTENT_URI
                }
            }
            else -> {
                throw NotSupportedMediaTypeException()
            }
        }
        val cursor = contentResolver.query(mediaUri, columns, where, null, sortOrder)
        if (cursor.moveToFirst()) {
            do {
                callback(cursor)
            } while (cursor.moveToNext())
        }
        cursor.close()
    }

    fun getCacheDir(): String {
        return Environment.getExternalStorageDirectory().absolutePath
    }

    fun createVideoThumbnail(videoPath: String, thumPath: String, result: MethodChannel.Result) {
        val file = File(thumPath)
        try {
            val bitmap = ThumbnailUtils.createVideoThumbnail(videoPath, MediaStore.Images.Thumbnails.MINI_KIND)
            if (file.exists()) {
                file.delete()
            }
            val dir = file.parentFile
            if (!dir.exists()) {
                dir.mkdirs()
            }
            if (file.createNewFile()) {
                val isOk = bitmap.compress(Bitmap.CompressFormat.JPEG, 50, file.outputStream())
                if (isOk) {
                    result.success(isOk)
                    return
                }
            }
            result.error("error", null, null)
        } catch (e: java.lang.Exception) {
            file.delete()
            result.error("error", null, null)
        }
    }

    fun createImageThumbnail(imagePath: String, thumPath: String, result: MethodChannel.Result) {
        val file = File(thumPath)
        try {
            var bitmap = BitmapFactory.decodeFile(imagePath)
            bitmap = ThumbnailUtils.extractThumbnail(bitmap, 300, 300)
            if (file.exists()) {
                file.delete()
            }
            val dir = file.parentFile
            if (!dir.exists()) {
                dir.mkdirs()
            }
            if (file.createNewFile()) {
                val isOk = bitmap.compress(Bitmap.CompressFormat.JPEG, 50, file.outputStream())
                if (isOk) {
                    result.success(isOk)
                    return
                }
            }
            result.error("error", null, null)
        } catch (e: java.lang.Exception) {
            file.delete()
            result.error("error", null, null)
        }
    }
}

const val Image = 1
const val Video = 2
const val Audio = 3

@IntDef(Image, Video, Audio)
@Target(AnnotationTarget.FIELD, AnnotationTarget.VALUE_PARAMETER)
@Retention
annotation class MediaType

data class AlbumInfo(val id: String, val name: String, val uri: String)

data class MediaInfo(
        val id: String,
        val name: String? = null,
        var date: Long? = null,
        val addDate: Long? = null,
        var modifyDate: Long? = null,
        val uri: String,
        var thumUri: String?,
        val mimeType: String?,
        @MediaType val mediaType: Int,
        val size: Long,
        val width: Int?=null,
        val heigth: Int?=null,
        val duration: Int?=null,
        var albumId: String?,
        var albumName: String?)

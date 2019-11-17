import 'dart:core';

enum MediaType{
  unKnow,
  image,
  video,
  audio
}

class MediaInfo {

  String id;
  String name;
  int date;
  int addDate;
  int modifyDate;
  String uri;
  String thumUri;
  String mimeType;
  int mediaType;
  int size;
  int width;
  int height;
  int duration;
  String albumId;
  String albumName;

  MediaInfo.fromMap(Map<String,dynamic> map){
    id=map["id"];
    name=map["name"];
    date=map["date"];
    addDate=map["addDate"];
    modifyDate=map["modifyDate"];
    uri=map["uri"];
    thumUri=map["thumUri"];
    mimeType=map["mimeType"];
    mediaType=map["mediaType"];
    size=map["size"];
    width=map["width"];
    height=map["heigth"];
    duration=map["duration"];
    albumId=map["albumId"];
    albumName=map["albumName"];
  }

  bool operator ==(mediaInfo){
    assert(mediaInfo!=null);
    return mediaInfo.id==this.id; 
  }

  int get hashCode=>id.hashCode;
}

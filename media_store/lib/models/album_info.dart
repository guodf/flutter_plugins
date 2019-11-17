class AlbumInfo {
  String id;
  String name;
  String uri;

  AlbumInfo.fromMap(Map<String,dynamic> map){
    id=map["id"] as String;
    name=map["name"] as String;
    uri=map["uri"] as String;
  }
}
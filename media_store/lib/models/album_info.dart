import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'album_info.g.dart';

abstract class AlbumInfo implements Built<AlbumInfo,AlbumInfoBuilder>{
  String get id;
  String get name;
  String get uri;

  AlbumInfo._();
  factory AlbumInfo([updates(AlbumInfoBuilder b)]) = _$AlbumInfo;
  static Serializer<AlbumInfo> get serializer => _$albumInfoSerializer;
}
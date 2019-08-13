import 'dart:core';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'media_info.g.dart';

enum MediaType{
  unKnow,
  image,
  video,
  audio
}

abstract class MediaInfo implements Built<MediaInfo, MediaInfoBuilder> {

  String get  id;
  @nullable
  String get name;
  int get date;
  int get addDate;
  int get modifyDate;
  String get uri;
  @nullable
  String get thumUri;
  @nullable
  String get mimeType;
  @nullable
  int get mediaType;
  @nullable
  int get size;
  @nullable
  String get albumId;
  @nullable
  String get albumName;
  @nullable
  String get position;

  MediaInfo._();
  factory MediaInfo([updates(MediaInfoBuilder b)]) = _$MediaInfo;
  static Serializer<MediaInfo> get serializer => _$mediaInfoSerializer;
}

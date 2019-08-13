library serializers;


import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:media_store/models/media_info.dart';
import 'package:media_store/models/album_info.dart';

part 'serializer.g.dart';

@SerializersFor(const [
 MediaInfo,
 AlbumInfo
])

final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
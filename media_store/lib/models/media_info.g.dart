// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MediaInfo> _$mediaInfoSerializer = new _$MediaInfoSerializer();

class _$MediaInfoSerializer implements StructuredSerializer<MediaInfo> {
  @override
  final Iterable<Type> types = const [MediaInfo, _$MediaInfo];
  @override
  final String wireName = 'MediaInfo';

  @override
  Iterable serialize(Serializers serializers, MediaInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(int)),
      'addDate',
      serializers.serialize(object.addDate, specifiedType: const FullType(int)),
      'modifyDate',
      serializers.serialize(object.modifyDate,
          specifiedType: const FullType(int)),
      'uri',
      serializers.serialize(object.uri, specifiedType: const FullType(String)),
    ];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.thumUri != null) {
      result
        ..add('thumUri')
        ..add(serializers.serialize(object.thumUri,
            specifiedType: const FullType(String)));
    }
    if (object.mimeType != null) {
      result
        ..add('mimeType')
        ..add(serializers.serialize(object.mimeType,
            specifiedType: const FullType(String)));
    }
    if (object.mediaType != null) {
      result
        ..add('mediaType')
        ..add(serializers.serialize(object.mediaType,
            specifiedType: const FullType(int)));
    }
    if (object.size != null) {
      result
        ..add('size')
        ..add(serializers.serialize(object.size,
            specifiedType: const FullType(int)));
    }
    if (object.albumId != null) {
      result
        ..add('albumId')
        ..add(serializers.serialize(object.albumId,
            specifiedType: const FullType(String)));
    }
    if (object.albumName != null) {
      result
        ..add('albumName')
        ..add(serializers.serialize(object.albumName,
            specifiedType: const FullType(String)));
    }
    if (object.position != null) {
      result
        ..add('position')
        ..add(serializers.serialize(object.position,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  MediaInfo deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MediaInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'addDate':
          result.addDate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'modifyDate':
          result.modifyDate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'uri':
          result.uri = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumUri':
          result.thumUri = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mimeType':
          result.mimeType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mediaType':
          result.mediaType = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'size':
          result.size = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'albumId':
          result.albumId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'albumName':
          result.albumName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$MediaInfo extends MediaInfo {
  @override
  final String id;
  @override
  final String name;
  @override
  final int date;
  @override
  final int addDate;
  @override
  final int modifyDate;
  @override
  final String uri;
  @override
  final String thumUri;
  @override
  final String mimeType;
  @override
  final int mediaType;
  @override
  final int size;
  @override
  final String albumId;
  @override
  final String albumName;
  @override
  final String position;

  factory _$MediaInfo([void updates(MediaInfoBuilder b)]) =>
      (new MediaInfoBuilder()..update(updates)).build();

  _$MediaInfo._(
      {this.id,
      this.name,
      this.date,
      this.addDate,
      this.modifyDate,
      this.uri,
      this.thumUri,
      this.mimeType,
      this.mediaType,
      this.size,
      this.albumId,
      this.albumName,
      this.position})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('MediaInfo', 'id');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('MediaInfo', 'date');
    }
    if (addDate == null) {
      throw new BuiltValueNullFieldError('MediaInfo', 'addDate');
    }
    if (modifyDate == null) {
      throw new BuiltValueNullFieldError('MediaInfo', 'modifyDate');
    }
    if (uri == null) {
      throw new BuiltValueNullFieldError('MediaInfo', 'uri');
    }
  }

  @override
  MediaInfo rebuild(void updates(MediaInfoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MediaInfoBuilder toBuilder() => new MediaInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MediaInfo &&
        id == other.id &&
        name == other.name &&
        date == other.date &&
        addDate == other.addDate &&
        modifyDate == other.modifyDate &&
        uri == other.uri &&
        thumUri == other.thumUri &&
        mimeType == other.mimeType &&
        mediaType == other.mediaType &&
        size == other.size &&
        albumId == other.albumId &&
        albumName == other.albumName &&
        position == other.position;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc($jc(0, id.hashCode),
                                                    name.hashCode),
                                                date.hashCode),
                                            addDate.hashCode),
                                        modifyDate.hashCode),
                                    uri.hashCode),
                                thumUri.hashCode),
                            mimeType.hashCode),
                        mediaType.hashCode),
                    size.hashCode),
                albumId.hashCode),
            albumName.hashCode),
        position.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MediaInfo')
          ..add('id', id)
          ..add('name', name)
          ..add('date', date)
          ..add('addDate', addDate)
          ..add('modifyDate', modifyDate)
          ..add('uri', uri)
          ..add('thumUri', thumUri)
          ..add('mimeType', mimeType)
          ..add('mediaType', mediaType)
          ..add('size', size)
          ..add('albumId', albumId)
          ..add('albumName', albumName)
          ..add('position', position))
        .toString();
  }
}

class MediaInfoBuilder implements Builder<MediaInfo, MediaInfoBuilder> {
  _$MediaInfo _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _date;
  int get date => _$this._date;
  set date(int date) => _$this._date = date;

  int _addDate;
  int get addDate => _$this._addDate;
  set addDate(int addDate) => _$this._addDate = addDate;

  int _modifyDate;
  int get modifyDate => _$this._modifyDate;
  set modifyDate(int modifyDate) => _$this._modifyDate = modifyDate;

  String _uri;
  String get uri => _$this._uri;
  set uri(String uri) => _$this._uri = uri;

  String _thumUri;
  String get thumUri => _$this._thumUri;
  set thumUri(String thumUri) => _$this._thumUri = thumUri;

  String _mimeType;
  String get mimeType => _$this._mimeType;
  set mimeType(String mimeType) => _$this._mimeType = mimeType;

  int _mediaType;
  int get mediaType => _$this._mediaType;
  set mediaType(int mediaType) => _$this._mediaType = mediaType;

  int _size;
  int get size => _$this._size;
  set size(int size) => _$this._size = size;

  String _albumId;
  String get albumId => _$this._albumId;
  set albumId(String albumId) => _$this._albumId = albumId;

  String _albumName;
  String get albumName => _$this._albumName;
  set albumName(String albumName) => _$this._albumName = albumName;

  String _position;
  String get position => _$this._position;
  set position(String position) => _$this._position = position;

  MediaInfoBuilder();

  MediaInfoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _date = _$v.date;
      _addDate = _$v.addDate;
      _modifyDate = _$v.modifyDate;
      _uri = _$v.uri;
      _thumUri = _$v.thumUri;
      _mimeType = _$v.mimeType;
      _mediaType = _$v.mediaType;
      _size = _$v.size;
      _albumId = _$v.albumId;
      _albumName = _$v.albumName;
      _position = _$v.position;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MediaInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MediaInfo;
  }

  @override
  void update(void updates(MediaInfoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MediaInfo build() {
    final _$result = _$v ??
        new _$MediaInfo._(
            id: id,
            name: name,
            date: date,
            addDate: addDate,
            modifyDate: modifyDate,
            uri: uri,
            thumUri: thumUri,
            mimeType: mimeType,
            mediaType: mediaType,
            size: size,
            albumId: albumId,
            albumName: albumName,
            position: position);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

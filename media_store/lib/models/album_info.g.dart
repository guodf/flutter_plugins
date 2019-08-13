// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AlbumInfo> _$albumInfoSerializer = new _$AlbumInfoSerializer();

class _$AlbumInfoSerializer implements StructuredSerializer<AlbumInfo> {
  @override
  final Iterable<Type> types = const [AlbumInfo, _$AlbumInfo];
  @override
  final String wireName = 'AlbumInfo';

  @override
  Iterable serialize(Serializers serializers, AlbumInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'uri',
      serializers.serialize(object.uri, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  AlbumInfo deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AlbumInfoBuilder();

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
        case 'uri':
          result.uri = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AlbumInfo extends AlbumInfo {
  @override
  final String id;
  @override
  final String name;
  @override
  final String uri;

  factory _$AlbumInfo([void updates(AlbumInfoBuilder b)]) =>
      (new AlbumInfoBuilder()..update(updates)).build();

  _$AlbumInfo._({this.id, this.name, this.uri}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('AlbumInfo', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('AlbumInfo', 'name');
    }
    if (uri == null) {
      throw new BuiltValueNullFieldError('AlbumInfo', 'uri');
    }
  }

  @override
  AlbumInfo rebuild(void updates(AlbumInfoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AlbumInfoBuilder toBuilder() => new AlbumInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AlbumInfo &&
        id == other.id &&
        name == other.name &&
        uri == other.uri;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), name.hashCode), uri.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AlbumInfo')
          ..add('id', id)
          ..add('name', name)
          ..add('uri', uri))
        .toString();
  }
}

class AlbumInfoBuilder implements Builder<AlbumInfo, AlbumInfoBuilder> {
  _$AlbumInfo _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _uri;
  String get uri => _$this._uri;
  set uri(String uri) => _$this._uri = uri;

  AlbumInfoBuilder();

  AlbumInfoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _uri = _$v.uri;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AlbumInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AlbumInfo;
  }

  @override
  void update(void updates(AlbumInfoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AlbumInfo build() {
    final _$result = _$v ?? new _$AlbumInfo._(id: id, name: name, uri: uri);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

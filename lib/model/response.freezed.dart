// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return _Response.fromJson(json);
}

/// @nodoc
class _$ResponseTearOff {
  const _$ResponseTearOff();

  _Response call(
      {required String apiKey,
      required List<NotebookEntry> entries,
      required int formatVersion,
      required int id,
      required int revision}) {
    return _Response(
      apiKey: apiKey,
      entries: entries,
      formatVersion: formatVersion,
      id: id,
      revision: revision,
    );
  }

  Response fromJson(Map<String, Object> json) {
    return Response.fromJson(json);
  }
}

/// @nodoc
const $Response = _$ResponseTearOff();

/// @nodoc
mixin _$Response {
  String get apiKey => throw _privateConstructorUsedError;
  List<NotebookEntry> get entries => throw _privateConstructorUsedError;
  int get formatVersion => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int get revision => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseCopyWith<Response> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseCopyWith<$Res> {
  factory $ResponseCopyWith(Response value, $Res Function(Response) then) =
      _$ResponseCopyWithImpl<$Res>;
  $Res call(
      {String apiKey,
      List<NotebookEntry> entries,
      int formatVersion,
      int id,
      int revision});
}

/// @nodoc
class _$ResponseCopyWithImpl<$Res> implements $ResponseCopyWith<$Res> {
  _$ResponseCopyWithImpl(this._value, this._then);

  final Response _value;
  // ignore: unused_field
  final $Res Function(Response) _then;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? entries = freezed,
    Object? formatVersion = freezed,
    Object? id = freezed,
    Object? revision = freezed,
  }) {
    return _then(_value.copyWith(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      entries: entries == freezed
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<NotebookEntry>,
      formatVersion: formatVersion == freezed
          ? _value.formatVersion
          : formatVersion // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      revision: revision == freezed
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ResponseCopyWith<$Res> implements $ResponseCopyWith<$Res> {
  factory _$ResponseCopyWith(_Response value, $Res Function(_Response) then) =
      __$ResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String apiKey,
      List<NotebookEntry> entries,
      int formatVersion,
      int id,
      int revision});
}

/// @nodoc
class __$ResponseCopyWithImpl<$Res> extends _$ResponseCopyWithImpl<$Res>
    implements _$ResponseCopyWith<$Res> {
  __$ResponseCopyWithImpl(_Response _value, $Res Function(_Response) _then)
      : super(_value, (v) => _then(v as _Response));

  @override
  _Response get _value => super._value as _Response;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? entries = freezed,
    Object? formatVersion = freezed,
    Object? id = freezed,
    Object? revision = freezed,
  }) {
    return _then(_Response(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      entries: entries == freezed
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<NotebookEntry>,
      formatVersion: formatVersion == freezed
          ? _value.formatVersion
          : formatVersion // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      revision: revision == freezed
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Response implements _Response {
  _$_Response(
      {required this.apiKey,
      required this.entries,
      required this.formatVersion,
      required this.id,
      required this.revision});

  factory _$_Response.fromJson(Map<String, dynamic> json) =>
      _$_$_ResponseFromJson(json);

  @override
  final String apiKey;
  @override
  final List<NotebookEntry> entries;
  @override
  final int formatVersion;
  @override
  final int id;
  @override
  final int revision;

  @override
  String toString() {
    return 'Response(apiKey: $apiKey, entries: $entries, formatVersion: $formatVersion, id: $id, revision: $revision)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Response &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.entries, entries) ||
                const DeepCollectionEquality()
                    .equals(other.entries, entries)) &&
            (identical(other.formatVersion, formatVersion) ||
                const DeepCollectionEquality()
                    .equals(other.formatVersion, formatVersion)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.revision, revision) ||
                const DeepCollectionEquality()
                    .equals(other.revision, revision)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(entries) ^
      const DeepCollectionEquality().hash(formatVersion) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(revision);

  @JsonKey(ignore: true)
  @override
  _$ResponseCopyWith<_Response> get copyWith =>
      __$ResponseCopyWithImpl<_Response>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ResponseToJson(this);
  }
}

abstract class _Response implements Response {
  factory _Response(
      {required String apiKey,
      required List<NotebookEntry> entries,
      required int formatVersion,
      required int id,
      required int revision}) = _$_Response;

  factory _Response.fromJson(Map<String, dynamic> json) = _$_Response.fromJson;

  @override
  String get apiKey => throw _privateConstructorUsedError;
  @override
  List<NotebookEntry> get entries => throw _privateConstructorUsedError;
  @override
  int get formatVersion => throw _privateConstructorUsedError;
  @override
  int get id => throw _privateConstructorUsedError;
  @override
  int get revision => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ResponseCopyWith<_Response> get copyWith =>
      throw _privateConstructorUsedError;
}

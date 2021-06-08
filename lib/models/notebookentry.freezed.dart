// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'notebookentry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotebookEntry _$NotebookEntryFromJson(Map<String, dynamic> json) {
  return _NotebookEntry.fromJson(json);
}

/// @nodoc
class _$NotebookEntryTearOff {
  const _$NotebookEntryTearOff();

  _NotebookEntry call(
      {required String addedDate,
      required List<Definition> definitions,
      required int id}) {
    return _NotebookEntry(
      addedDate: addedDate,
      definitions: definitions,
      id: id,
    );
  }

  NotebookEntry fromJson(Map<String, Object> json) {
    return NotebookEntry.fromJson(json);
  }
}

/// @nodoc
const $NotebookEntry = _$NotebookEntryTearOff();

/// @nodoc
mixin _$NotebookEntry {
  String get addedDate => throw _privateConstructorUsedError;
  List<Definition> get definitions => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotebookEntryCopyWith<NotebookEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotebookEntryCopyWith<$Res> {
  factory $NotebookEntryCopyWith(
          NotebookEntry value, $Res Function(NotebookEntry) then) =
      _$NotebookEntryCopyWithImpl<$Res>;
  $Res call({String addedDate, List<Definition> definitions, int id});
}

/// @nodoc
class _$NotebookEntryCopyWithImpl<$Res>
    implements $NotebookEntryCopyWith<$Res> {
  _$NotebookEntryCopyWithImpl(this._value, this._then);

  final NotebookEntry _value;
  // ignore: unused_field
  final $Res Function(NotebookEntry) _then;

  @override
  $Res call({
    Object? addedDate = freezed,
    Object? definitions = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      addedDate: addedDate == freezed
          ? _value.addedDate
          : addedDate // ignore: cast_nullable_to_non_nullable
              as String,
      definitions: definitions == freezed
          ? _value.definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<Definition>,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$NotebookEntryCopyWith<$Res>
    implements $NotebookEntryCopyWith<$Res> {
  factory _$NotebookEntryCopyWith(
          _NotebookEntry value, $Res Function(_NotebookEntry) then) =
      __$NotebookEntryCopyWithImpl<$Res>;
  @override
  $Res call({String addedDate, List<Definition> definitions, int id});
}

/// @nodoc
class __$NotebookEntryCopyWithImpl<$Res>
    extends _$NotebookEntryCopyWithImpl<$Res>
    implements _$NotebookEntryCopyWith<$Res> {
  __$NotebookEntryCopyWithImpl(
      _NotebookEntry _value, $Res Function(_NotebookEntry) _then)
      : super(_value, (v) => _then(v as _NotebookEntry));

  @override
  _NotebookEntry get _value => super._value as _NotebookEntry;

  @override
  $Res call({
    Object? addedDate = freezed,
    Object? definitions = freezed,
    Object? id = freezed,
  }) {
    return _then(_NotebookEntry(
      addedDate: addedDate == freezed
          ? _value.addedDate
          : addedDate // ignore: cast_nullable_to_non_nullable
              as String,
      definitions: definitions == freezed
          ? _value.definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<Definition>,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_NotebookEntry implements _NotebookEntry {
  _$_NotebookEntry(
      {required this.addedDate, required this.definitions, required this.id});

  factory _$_NotebookEntry.fromJson(Map<String, dynamic> json) =>
      _$_$_NotebookEntryFromJson(json);

  @override
  final String addedDate;
  @override
  final List<Definition> definitions;
  @override
  final int id;

  @override
  String toString() {
    return 'NotebookEntry(addedDate: $addedDate, definitions: $definitions, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotebookEntry &&
            (identical(other.addedDate, addedDate) ||
                const DeepCollectionEquality()
                    .equals(other.addedDate, addedDate)) &&
            (identical(other.definitions, definitions) ||
                const DeepCollectionEquality()
                    .equals(other.definitions, definitions)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(addedDate) ^
      const DeepCollectionEquality().hash(definitions) ^
      const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$NotebookEntryCopyWith<_NotebookEntry> get copyWith =>
      __$NotebookEntryCopyWithImpl<_NotebookEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NotebookEntryToJson(this);
  }
}

abstract class _NotebookEntry implements NotebookEntry {
  factory _NotebookEntry(
      {required String addedDate,
      required List<Definition> definitions,
      required int id}) = _$_NotebookEntry;

  factory _NotebookEntry.fromJson(Map<String, dynamic> json) =
      _$_NotebookEntry.fromJson;

  @override
  String get addedDate => throw _privateConstructorUsedError;
  @override
  List<Definition> get definitions => throw _privateConstructorUsedError;
  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NotebookEntryCopyWith<_NotebookEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

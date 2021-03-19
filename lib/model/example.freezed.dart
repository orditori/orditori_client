// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'example.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Example _$ExampleFromJson(Map<String, dynamic> json) {
  return _Example.fromJson(json);
}

/// @nodoc
class _$ExampleTearOff {
  const _$ExampleTearOff();

  _Example call(
      {int? definition, int? id, required String string, String? translation}) {
    return _Example(
      definition: definition,
      id: id,
      string: string,
      translation: translation,
    );
  }

  Example fromJson(Map<String, Object> json) {
    return Example.fromJson(json);
  }
}

/// @nodoc
const $Example = _$ExampleTearOff();

/// @nodoc
mixin _$Example {
  int? get definition => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String get string => throw _privateConstructorUsedError;
  String? get translation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExampleCopyWith<Example> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleCopyWith<$Res> {
  factory $ExampleCopyWith(Example value, $Res Function(Example) then) =
      _$ExampleCopyWithImpl<$Res>;
  $Res call({int? definition, int? id, String string, String? translation});
}

/// @nodoc
class _$ExampleCopyWithImpl<$Res> implements $ExampleCopyWith<$Res> {
  _$ExampleCopyWithImpl(this._value, this._then);

  final Example _value;
  // ignore: unused_field
  final $Res Function(Example) _then;

  @override
  $Res call({
    Object? definition = freezed,
    Object? id = freezed,
    Object? string = freezed,
    Object? translation = freezed,
  }) {
    return _then(_value.copyWith(
      definition: definition == freezed
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as int?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      string: string == freezed
          ? _value.string
          : string // ignore: cast_nullable_to_non_nullable
              as String,
      translation: translation == freezed
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ExampleCopyWith<$Res> implements $ExampleCopyWith<$Res> {
  factory _$ExampleCopyWith(_Example value, $Res Function(_Example) then) =
      __$ExampleCopyWithImpl<$Res>;
  @override
  $Res call({int? definition, int? id, String string, String? translation});
}

/// @nodoc
class __$ExampleCopyWithImpl<$Res> extends _$ExampleCopyWithImpl<$Res>
    implements _$ExampleCopyWith<$Res> {
  __$ExampleCopyWithImpl(_Example _value, $Res Function(_Example) _then)
      : super(_value, (v) => _then(v as _Example));

  @override
  _Example get _value => super._value as _Example;

  @override
  $Res call({
    Object? definition = freezed,
    Object? id = freezed,
    Object? string = freezed,
    Object? translation = freezed,
  }) {
    return _then(_Example(
      definition: definition == freezed
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as int?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      string: string == freezed
          ? _value.string
          : string // ignore: cast_nullable_to_non_nullable
              as String,
      translation: translation == freezed
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Example implements _Example {
  _$_Example(
      {this.definition, this.id, required this.string, this.translation});

  factory _$_Example.fromJson(Map<String, dynamic> json) =>
      _$_$_ExampleFromJson(json);

  @override
  final int? definition;
  @override
  final int? id;
  @override
  final String string;
  @override
  final String? translation;

  @override
  String toString() {
    return 'Example(definition: $definition, id: $id, string: $string, translation: $translation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Example &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.string, string) ||
                const DeepCollectionEquality().equals(other.string, string)) &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(string) ^
      const DeepCollectionEquality().hash(translation);

  @JsonKey(ignore: true)
  @override
  _$ExampleCopyWith<_Example> get copyWith =>
      __$ExampleCopyWithImpl<_Example>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ExampleToJson(this);
  }
}

abstract class _Example implements Example {
  factory _Example(
      {int? definition,
      int? id,
      required String string,
      String? translation}) = _$_Example;

  factory _Example.fromJson(Map<String, dynamic> json) = _$_Example.fromJson;

  @override
  int? get definition => throw _privateConstructorUsedError;
  @override
  int? get id => throw _privateConstructorUsedError;
  @override
  String get string => throw _privateConstructorUsedError;
  @override
  String? get translation => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ExampleCopyWith<_Example> get copyWith =>
      throw _privateConstructorUsedError;
}

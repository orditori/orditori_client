// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Definition _$DefinitionFromJson(Map<String, dynamic> json) {
  return _Definition.fromJson(json);
}

/// @nodoc
class _$DefinitionTearOff {
  const _$DefinitionTearOff();

  _Definition call(
      {int? id,
      required String definition,
      required List<Example> examples,
      required Language language,
      required String word}) {
    return _Definition(
      id: id,
      definition: definition,
      examples: examples,
      language: language,
      word: word,
    );
  }

  Definition fromJson(Map<String, Object> json) {
    return Definition.fromJson(json);
  }
}

/// @nodoc
const $Definition = _$DefinitionTearOff();

/// @nodoc
mixin _$Definition {
  int? get id => throw _privateConstructorUsedError;
  String get definition => throw _privateConstructorUsedError;
  List<Example> get examples => throw _privateConstructorUsedError;
  Language get language => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DefinitionCopyWith<Definition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DefinitionCopyWith<$Res> {
  factory $DefinitionCopyWith(
          Definition value, $Res Function(Definition) then) =
      _$DefinitionCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String definition,
      List<Example> examples,
      Language language,
      String word});

  $LanguageCopyWith<$Res> get language;
}

/// @nodoc
class _$DefinitionCopyWithImpl<$Res> implements $DefinitionCopyWith<$Res> {
  _$DefinitionCopyWithImpl(this._value, this._then);

  final Definition _value;
  // ignore: unused_field
  final $Res Function(Definition) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? definition = freezed,
    Object? examples = freezed,
    Object? language = freezed,
    Object? word = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      definition: definition == freezed
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String,
      examples: examples == freezed
          ? _value.examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<Example>,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
      word: word == freezed
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $LanguageCopyWith<$Res> get language {
    return $LanguageCopyWith<$Res>(_value.language, (value) {
      return _then(_value.copyWith(language: value));
    });
  }
}

/// @nodoc
abstract class _$DefinitionCopyWith<$Res> implements $DefinitionCopyWith<$Res> {
  factory _$DefinitionCopyWith(
          _Definition value, $Res Function(_Definition) then) =
      __$DefinitionCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String definition,
      List<Example> examples,
      Language language,
      String word});

  @override
  $LanguageCopyWith<$Res> get language;
}

/// @nodoc
class __$DefinitionCopyWithImpl<$Res> extends _$DefinitionCopyWithImpl<$Res>
    implements _$DefinitionCopyWith<$Res> {
  __$DefinitionCopyWithImpl(
      _Definition _value, $Res Function(_Definition) _then)
      : super(_value, (v) => _then(v as _Definition));

  @override
  _Definition get _value => super._value as _Definition;

  @override
  $Res call({
    Object? id = freezed,
    Object? definition = freezed,
    Object? examples = freezed,
    Object? language = freezed,
    Object? word = freezed,
  }) {
    return _then(_Definition(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      definition: definition == freezed
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String,
      examples: examples == freezed
          ? _value.examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<Example>,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
      word: word == freezed
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Definition implements _Definition {
  _$_Definition(
      {this.id,
      required this.definition,
      required this.examples,
      required this.language,
      required this.word});

  factory _$_Definition.fromJson(Map<String, dynamic> json) =>
      _$_$_DefinitionFromJson(json);

  @override
  final int? id;
  @override
  final String definition;
  @override
  final List<Example> examples;
  @override
  final Language language;
  @override
  final String word;

  @override
  String toString() {
    return 'Definition(id: $id, definition: $definition, examples: $examples, language: $language, word: $word)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Definition &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.examples, examples) ||
                const DeepCollectionEquality()
                    .equals(other.examples, examples)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(examples) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(word);

  @JsonKey(ignore: true)
  @override
  _$DefinitionCopyWith<_Definition> get copyWith =>
      __$DefinitionCopyWithImpl<_Definition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DefinitionToJson(this);
  }
}

abstract class _Definition implements Definition {
  factory _Definition(
      {int? id,
      required String definition,
      required List<Example> examples,
      required Language language,
      required String word}) = _$_Definition;

  factory _Definition.fromJson(Map<String, dynamic> json) =
      _$_Definition.fromJson;

  @override
  int? get id => throw _privateConstructorUsedError;
  @override
  String get definition => throw _privateConstructorUsedError;
  @override
  List<Example> get examples => throw _privateConstructorUsedError;
  @override
  Language get language => throw _privateConstructorUsedError;
  @override
  String get word => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DefinitionCopyWith<_Definition> get copyWith =>
      throw _privateConstructorUsedError;
}

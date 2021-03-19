// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Definition _$_$_DefinitionFromJson(Map<String, dynamic> json) {
  return _$_Definition(
    id: json['id'] as int?,
    definition: json['definition'] as String,
    examples: (json['examples'] as List<dynamic>)
        .map((e) => Example.fromJson(e as Map<String, dynamic>))
        .toList(),
    language: Language.fromJson(json['language'] as Map<String, dynamic>),
    word: json['word'] as String,
  );
}

Map<String, dynamic> _$_$_DefinitionToJson(_$_Definition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'definition': instance.definition,
      'examples': instance.examples,
      'language': instance.language,
      'word': instance.word,
    };

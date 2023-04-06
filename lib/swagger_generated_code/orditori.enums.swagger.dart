import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum PartOfSpeech {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Noun')
  noun('Noun'),
  @JsonValue('ProperNoun')
  propernoun('ProperNoun'),
  @JsonValue('Verb')
  verb('Verb'),
  @JsonValue('Adjective')
  adjective('Adjective'),
  @JsonValue('Adverb')
  adverb('Adverb'),
  @JsonValue('Pronoun')
  pronoun('Pronoun'),
  @JsonValue('Preposition')
  preposition('Preposition'),
  @JsonValue('Conjunction')
  conjunction('Conjunction'),
  @JsonValue('Interjection')
  interjection('Interjection'),
  @JsonValue('Article')
  article('Article'),
  @JsonValue('Determiner')
  determiner('Determiner');

  final String? value;

  const PartOfSpeech(this.value);
}

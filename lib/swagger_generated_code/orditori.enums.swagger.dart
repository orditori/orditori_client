import 'package:json_annotation/json_annotation.dart';

enum PartOfSpeech {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('Noun')
  noun,
  @JsonValue('Verb')
  verb,
  @JsonValue('Adjective')
  adjective,
  @JsonValue('Adverb')
  adverb,
  @JsonValue('Pronoun')
  pronoun,
  @JsonValue('Preposition')
  preposition,
  @JsonValue('Conjunction')
  conjunction,
  @JsonValue('Interjection')
  interjection,
  @JsonValue('Article')
  article
}

const $PartOfSpeechMap = {
  PartOfSpeech.noun: 'Noun',
  PartOfSpeech.verb: 'Verb',
  PartOfSpeech.adjective: 'Adjective',
  PartOfSpeech.adverb: 'Adverb',
  PartOfSpeech.pronoun: 'Pronoun',
  PartOfSpeech.preposition: 'Preposition',
  PartOfSpeech.conjunction: 'Conjunction',
  PartOfSpeech.interjection: 'Interjection',
  PartOfSpeech.article: 'Article'
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orditori.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotebookR _$NotebookRFromJson(Map<String, dynamic> json) => NotebookR(
      id: json['id'] as int?,
      apiKey: json['apiKey'] as String?,
      revision: json['revision'] as int?,
      formatVersion: json['formatVersion'] as int?,
      entries: (json['entries'] as List<dynamic>?)
              ?.map((e) => NotebookEntryR.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$NotebookRToJson(NotebookR instance) => <String, dynamic>{
      'id': instance.id,
      'apiKey': instance.apiKey,
      'revision': instance.revision,
      'formatVersion': instance.formatVersion,
      'entries': instance.entries?.map((e) => e.toJson()).toList(),
    };

Id _$IdFromJson(Map<String, dynamic> json) => Id(
      untyped: json['untyped'] as int?,
    );

Map<String, dynamic> _$IdToJson(Id instance) => <String, dynamic>{
      'untyped': instance.untyped,
    };

NotebookEntryR _$NotebookEntryRFromJson(Map<String, dynamic> json) =>
    NotebookEntryR(
      id: json['id'] as int?,
      addedDate: json['addedDate'] as String?,
      definitions: (json['definitions'] as List<dynamic>?)
              ?.map((e) =>
                  DefinitionContentItemR.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$NotebookEntryRToJson(NotebookEntryR instance) =>
    <String, dynamic>{
      'id': instance.id,
      'addedDate': instance.addedDate,
      'definitions': instance.definitions?.map((e) => e.toJson()).toList(),
    };

DefinitionContentItemR _$DefinitionContentItemRFromJson(
        Map<String, dynamic> json) =>
    DefinitionContentItemR(
      id: json['id'] as int?,
      word: json['word'] as String?,
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      definition: json['definition'] as String?,
      examples: (json['examples'] as List<dynamic>?)
              ?.map(
                  (e) => DefinitionExample.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DefinitionContentItemRToJson(
        DefinitionContentItemR instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'language': instance.language?.toJson(),
      'definition': instance.definition,
      'examples': instance.examples?.map((e) => e.toJson()).toList(),
    };

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      code: json['code'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

DefinitionExample _$DefinitionExampleFromJson(Map<String, dynamic> json) =>
    DefinitionExample(
      id: json['id'] as int?,
      definition: json['definition'] as int?,
      $String: json['string'] as String?,
      translation: json['translation'] as String?,
    );

Map<String, dynamic> _$DefinitionExampleToJson(DefinitionExample instance) =>
    <String, dynamic>{
      'id': instance.id,
      'definition': instance.definition,
      'string': instance.$String,
      'translation': instance.translation,
    };

NotebookEntryW _$NotebookEntryWFromJson(Map<String, dynamic> json) =>
    NotebookEntryW(
      notebook: json['notebook'] as int?,
      addedDate: json['addedDate'] as String?,
    );

Map<String, dynamic> _$NotebookEntryWToJson(NotebookEntryW instance) =>
    <String, dynamic>{
      'notebook': instance.notebook,
      'addedDate': instance.addedDate,
    };

Definition _$DefinitionFromJson(Map<String, dynamic> json) => Definition(
      word: json['word'] as String?,
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      definition: json['definition'] as String?,
      examples: (json['examples'] as List<dynamic>?)
              ?.map((e) => Example.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DefinitionToJson(Definition instance) =>
    <String, dynamic>{
      'word': instance.word,
      'language': instance.language?.toJson(),
      'definition': instance.definition,
      'examples': instance.examples?.map((e) => e.toJson()).toList(),
    };

Example _$ExampleFromJson(Map<String, dynamic> json) => Example(
      $String: json['string'] as String?,
      translation: json['translation'] as String?,
    );

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
      'string': instance.$String,
      'translation': instance.translation,
    };

DefinitionExampleW _$DefinitionExampleWFromJson(Map<String, dynamic> json) =>
    DefinitionExampleW(
      definition: json['definition'] as int?,
      $String: json['string'] as String?,
      translation: json['translation'] as String?,
    );

Map<String, dynamic> _$DefinitionExampleWToJson(DefinitionExampleW instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'string': instance.$String,
      'translation': instance.translation,
    };

DefinitionContentItemW _$DefinitionContentItemWFromJson(
        Map<String, dynamic> json) =>
    DefinitionContentItemW(
      entry: json['entry'] as int?,
      word: json['word'] as String?,
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      definition: json['definition'] as String?,
    );

Map<String, dynamic> _$DefinitionContentItemWToJson(
        DefinitionContentItemW instance) =>
    <String, dynamic>{
      'entry': instance.entry,
      'word': instance.word,
      'language': instance.language?.toJson(),
      'definition': instance.definition,
    };

DefinitionExerciseR _$DefinitionExerciseRFromJson(Map<String, dynamic> json) =>
    DefinitionExerciseR(
      id: json['id'] as int?,
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      definition: json['definition'] as String?,
      difficultyScore: (json['difficultyScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DefinitionExerciseRToJson(
        DefinitionExerciseR instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': instance.language?.toJson(),
      'definition': instance.definition,
      'difficultyScore': instance.difficultyScore,
    };

SolutionCheckResult _$SolutionCheckResultFromJson(Map<String, dynamic> json) =>
    SolutionCheckResult(
      incorrect: json['Incorrect'] as String?,
      correct: (json['Correct'] as List<dynamic>?)
              ?.map(
                  (e) => FuzzyCompareToken.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SolutionCheckResultToJson(
        SolutionCheckResult instance) =>
    <String, dynamic>{
      'Incorrect': instance.incorrect,
      'Correct': instance.correct?.map((e) => e.toJson()).toList(),
    };

FuzzyCompareToken _$FuzzyCompareTokenFromJson(Map<String, dynamic> json) =>
    FuzzyCompareToken(
      character: json['Character'] as String?,
      issue: json['Issue'] == null
          ? null
          : FuzzyCompareIssue.fromJson(json['Issue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FuzzyCompareTokenToJson(FuzzyCompareToken instance) =>
    <String, dynamic>{
      'Character': instance.character,
      'Issue': instance.issue?.toJson(),
    };

FuzzyCompareIssue _$FuzzyCompareIssueFromJson(Map<String, dynamic> json) =>
    FuzzyCompareIssue(
      expected: json['expected'] as String?,
      actual: json['actual'] as String?,
    );

Map<String, dynamic> _$FuzzyCompareIssueToJson(FuzzyCompareIssue instance) =>
    <String, dynamic>{
      'expected': instance.expected,
      'actual': instance.actual,
    };

ExerciseSolution _$ExerciseSolutionFromJson(Map<String, dynamic> json) =>
    ExerciseSolution(
      exercise: json['exercise'] as int?,
      input: json['input'] as String?,
    );

Map<String, dynamic> _$ExerciseSolutionToJson(ExerciseSolution instance) =>
    <String, dynamic>{
      'exercise': instance.exercise,
      'input': instance.input,
    };

DefinitionExerciseStats _$DefinitionExerciseStatsFromJson(
        Map<String, dynamic> json) =>
    DefinitionExerciseStats(
      id: json['id'] as int?,
      definition: json['definition'] == null
          ? null
          : DefinitionContentItem.fromJson(
              json['definition'] as Map<String, dynamic>),
      difficultyScore: (json['difficultyScore'] as num?)?.toDouble(),
      correct: json['correct'] as int?,
      incorrect: json['incorrect'] as int?,
    );

Map<String, dynamic> _$DefinitionExerciseStatsToJson(
        DefinitionExerciseStats instance) =>
    <String, dynamic>{
      'id': instance.id,
      'definition': instance.definition?.toJson(),
      'difficultyScore': instance.difficultyScore,
      'correct': instance.correct,
      'incorrect': instance.incorrect,
    };

DefinitionContentItem _$DefinitionContentItemFromJson(
        Map<String, dynamic> json) =>
    DefinitionContentItem(
      id: json['id'] as int?,
      entry: json['entry'] as int?,
      word: json['word'] as String?,
      language: json['language'] as String?,
      definition: json['definition'] as String?,
    );

Map<String, dynamic> _$DefinitionContentItemToJson(
        DefinitionContentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entry': instance.entry,
      'word': instance.word,
      'language': instance.language,
      'definition': instance.definition,
    };

DefinitionExampleExerciseR _$DefinitionExampleExerciseRFromJson(
        Map<String, dynamic> json) =>
    DefinitionExampleExerciseR(
      id: json['id'] as int?,
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      definition: json['definition'] as String?,
      example: (json['example'] as List<dynamic>?)
              ?.map((e) => StringOrGap.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      difficultyScore: (json['difficultyScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DefinitionExampleExerciseRToJson(
        DefinitionExampleExerciseR instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': instance.language?.toJson(),
      'definition': instance.definition,
      'example': instance.example?.map((e) => e.toJson()).toList(),
      'difficultyScore': instance.difficultyScore,
    };

StringOrGap _$StringOrGapFromJson(Map<String, dynamic> json) => StringOrGap(
      gap: json['Gap'] as int?,
      $String: json['String'] as String?,
    );

Map<String, dynamic> _$StringOrGapToJson(StringOrGap instance) =>
    <String, dynamic>{
      'Gap': instance.gap,
      'String': instance.$String,
    };

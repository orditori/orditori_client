// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orditori.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotebookR _$NotebookRFromJson(Map<String, dynamic> json) => NotebookR(
      entries: (json['entries'] as List<dynamic>?)
              ?.map((e) => NotebookEntryR.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['id'] as int?,
      revision: json['revision'] as int?,
      apiKey: json['apiKey'] as String?,
      formatVersion: json['formatVersion'] as int?,
    );

Map<String, dynamic> _$NotebookRToJson(NotebookR instance) => <String, dynamic>{
      'entries': instance.entries?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'revision': instance.revision,
      'apiKey': instance.apiKey,
      'formatVersion': instance.formatVersion,
    };

NotebookEntryR _$NotebookEntryRFromJson(Map<String, dynamic> json) =>
    NotebookEntryR(
      addedDate: json['addedDate'] as String?,
      id: json['id'] as int?,
      definitions: (json['definitions'] as List<dynamic>?)
              ?.map((e) =>
                  DefinitionContentItemR.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$NotebookEntryRToJson(NotebookEntryR instance) =>
    <String, dynamic>{
      'addedDate': instance.addedDate,
      'id': instance.id,
      'definitions': instance.definitions?.map((e) => e.toJson()).toList(),
    };

DefinitionContentItemR _$DefinitionContentItemRFromJson(
        Map<String, dynamic> json) =>
    DefinitionContentItemR(
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      id: json['id'] as int?,
      sourceLink: json['sourceLink'] as String?,
      definitionSource: json['definitionSource'] as int?,
      word: json['word'] as String?,
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
      'language': instance.language?.toJson(),
      'id': instance.id,
      'sourceLink': instance.sourceLink,
      'definitionSource': instance.definitionSource,
      'word': instance.word,
      'definition': instance.definition,
      'examples': instance.examples?.map((e) => e.toJson()).toList(),
    };

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
    };

DefinitionExample _$DefinitionExampleFromJson(Map<String, dynamic> json) =>
    DefinitionExample(
      id: json['id'] as int?,
      translation: json['translation'] as String?,
      definition: json['definition'] as int?,
      $String: json['string'] as String?,
    );

Map<String, dynamic> _$DefinitionExampleToJson(DefinitionExample instance) =>
    <String, dynamic>{
      'id': instance.id,
      'translation': instance.translation,
      'definition': instance.definition,
      'string': instance.$String,
    };

NotebookEntryW _$NotebookEntryWFromJson(Map<String, dynamic> json) =>
    NotebookEntryW(
      addedDate: json['addedDate'] as String?,
      notebook: json['notebook'] as int?,
    );

Map<String, dynamic> _$NotebookEntryWToJson(NotebookEntryW instance) =>
    <String, dynamic>{
      'addedDate': instance.addedDate,
      'notebook': instance.notebook,
    };

DefinitionsWithSource _$DefinitionsWithSourceFromJson(
        Map<String, dynamic> json) =>
    DefinitionsWithSource(
      definitionSource: json['definitionSource'] == null
          ? null
          : DefinitionSource.fromJson(
              json['definitionSource'] as Map<String, dynamic>),
      definitions: (json['definitions'] as List<dynamic>?)
              ?.map((e) => Definition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DefinitionsWithSourceToJson(
        DefinitionsWithSource instance) =>
    <String, dynamic>{
      'definitionSource': instance.definitionSource?.toJson(),
      'definitions': instance.definitions?.map((e) => e.toJson()).toList(),
    };

Definition _$DefinitionFromJson(Map<String, dynamic> json) => Definition(
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      sourceLink: json['sourceLink'] as String?,
      word: json['word'] as String?,
      definition: json['definition'] as String?,
      examples: (json['examples'] as List<dynamic>?)
              ?.map((e) => Example.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DefinitionToJson(Definition instance) =>
    <String, dynamic>{
      'language': instance.language?.toJson(),
      'sourceLink': instance.sourceLink,
      'word': instance.word,
      'definition': instance.definition,
      'examples': instance.examples?.map((e) => e.toJson()).toList(),
    };

Example _$ExampleFromJson(Map<String, dynamic> json) => Example(
      translation: json['translation'] as String?,
      $String: json['string'] as String?,
    );

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
      'translation': instance.translation,
      'string': instance.$String,
    };

DefinitionSource _$DefinitionSourceFromJson(Map<String, dynamic> json) =>
    DefinitionSource(
      name: json['name'] as String?,
      id: json['id'] as int?,
      scrapeUrl: json['scrapeUrl'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$DefinitionSourceToJson(DefinitionSource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'scrapeUrl': instance.scrapeUrl,
      'description': instance.description,
    };

DefinitionExampleW _$DefinitionExampleWFromJson(Map<String, dynamic> json) =>
    DefinitionExampleW(
      translation: json['translation'] as String?,
      definition: json['definition'] as int?,
      $String: json['string'] as String?,
    );

Map<String, dynamic> _$DefinitionExampleWToJson(DefinitionExampleW instance) =>
    <String, dynamic>{
      'translation': instance.translation,
      'definition': instance.definition,
      'string': instance.$String,
    };

DefinitionContentItemW _$DefinitionContentItemWFromJson(
        Map<String, dynamic> json) =>
    DefinitionContentItemW(
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      sourceLink: json['sourceLink'] as String?,
      definitionSource: json['definitionSource'] as int?,
      word: json['word'] as String?,
      definition: json['definition'] as String?,
      entry: json['entry'] as int?,
    );

Map<String, dynamic> _$DefinitionContentItemWToJson(
        DefinitionContentItemW instance) =>
    <String, dynamic>{
      'language': instance.language?.toJson(),
      'sourceLink': instance.sourceLink,
      'definitionSource': instance.definitionSource,
      'word': instance.word,
      'definition': instance.definition,
      'entry': instance.entry,
    };

DefinitionExerciseR _$DefinitionExerciseRFromJson(Map<String, dynamic> json) =>
    DefinitionExerciseR(
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      id: json['id'] as int?,
      definition: json['definition'] as String?,
      difficultyScore: (json['difficultyScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DefinitionExerciseRToJson(
        DefinitionExerciseR instance) =>
    <String, dynamic>{
      'language': instance.language?.toJson(),
      'id': instance.id,
      'definition': instance.definition,
      'difficultyScore': instance.difficultyScore,
    };

SolutionCheckResult _$SolutionCheckResultFromJson(Map<String, dynamic> json) =>
    SolutionCheckResult();

Map<String, dynamic> _$SolutionCheckResultToJson(
        SolutionCheckResult instance) =>
    <String, dynamic>{};

FuzzyCompareToken _$FuzzyCompareTokenFromJson(Map<String, dynamic> json) =>
    FuzzyCompareToken();

Map<String, dynamic> _$FuzzyCompareTokenToJson(FuzzyCompareToken instance) =>
    <String, dynamic>{};

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

ExerciseSolutionDefinitionExercise _$ExerciseSolutionDefinitionExerciseFromJson(
        Map<String, dynamic> json) =>
    ExerciseSolutionDefinitionExercise(
      exercise: json['exercise'] as int?,
      input: json['input'] as String?,
    );

Map<String, dynamic> _$ExerciseSolutionDefinitionExerciseToJson(
        ExerciseSolutionDefinitionExercise instance) =>
    <String, dynamic>{
      'exercise': instance.exercise,
      'input': instance.input,
    };

DefinitionExerciseStatsDefinitionExercise
    _$DefinitionExerciseStatsDefinitionExerciseFromJson(
            Map<String, dynamic> json) =>
        DefinitionExerciseStatsDefinitionExercise(
          correct: json['correct'] as int?,
          id: json['id'] as int?,
          incorrect: json['incorrect'] as int?,
          definition: json['definition'] == null
              ? null
              : DefinitionContentItem.fromJson(
                  json['definition'] as Map<String, dynamic>),
          difficultyScore: (json['difficultyScore'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$DefinitionExerciseStatsDefinitionExerciseToJson(
        DefinitionExerciseStatsDefinitionExercise instance) =>
    <String, dynamic>{
      'correct': instance.correct,
      'id': instance.id,
      'incorrect': instance.incorrect,
      'definition': instance.definition?.toJson(),
      'difficultyScore': instance.difficultyScore,
    };

DefinitionContentItem _$DefinitionContentItemFromJson(
        Map<String, dynamic> json) =>
    DefinitionContentItem(
      language: json['language'] as String?,
      id: json['id'] as int?,
      sourceLink: json['sourceLink'] as String?,
      definitionSource: json['definitionSource'] as int?,
      word: json['word'] as String?,
      definition: json['definition'] as String?,
      entry: json['entry'] as int?,
    );

Map<String, dynamic> _$DefinitionContentItemToJson(
        DefinitionContentItem instance) =>
    <String, dynamic>{
      'language': instance.language,
      'id': instance.id,
      'sourceLink': instance.sourceLink,
      'definitionSource': instance.definitionSource,
      'word': instance.word,
      'definition': instance.definition,
      'entry': instance.entry,
    };

DefinitionExampleExerciseR _$DefinitionExampleExerciseRFromJson(
        Map<String, dynamic> json) =>
    DefinitionExampleExerciseR(
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      id: json['id'] as int?,
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
      'language': instance.language?.toJson(),
      'id': instance.id,
      'definition': instance.definition,
      'example': instance.example?.map((e) => e.toJson()).toList(),
      'difficultyScore': instance.difficultyScore,
    };

StringOrGap _$StringOrGapFromJson(Map<String, dynamic> json) => StringOrGap();

Map<String, dynamic> _$StringOrGapToJson(StringOrGap instance) =>
    <String, dynamic>{};

ExerciseSolutionDefinitionExampleExercise
    _$ExerciseSolutionDefinitionExampleExerciseFromJson(
            Map<String, dynamic> json) =>
        ExerciseSolutionDefinitionExampleExercise(
          exercise: json['exercise'] as int?,
          input: json['input'] as String?,
        );

Map<String, dynamic> _$ExerciseSolutionDefinitionExampleExerciseToJson(
        ExerciseSolutionDefinitionExampleExercise instance) =>
    <String, dynamic>{
      'exercise': instance.exercise,
      'input': instance.input,
    };

DefinitionExerciseStatsDefinitionExampleExercise
    _$DefinitionExerciseStatsDefinitionExampleExerciseFromJson(
            Map<String, dynamic> json) =>
        DefinitionExerciseStatsDefinitionExampleExercise(
          correct: json['correct'] as int?,
          id: json['id'] as int?,
          incorrect: json['incorrect'] as int?,
          definition: json['definition'] == null
              ? null
              : DefinitionContentItem.fromJson(
                  json['definition'] as Map<String, dynamic>),
          difficultyScore: (json['difficultyScore'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$DefinitionExerciseStatsDefinitionExampleExerciseToJson(
        DefinitionExerciseStatsDefinitionExampleExercise instance) =>
    <String, dynamic>{
      'correct': instance.correct,
      'id': instance.id,
      'incorrect': instance.incorrect,
      'definition': instance.definition?.toJson(),
      'difficultyScore': instance.difficultyScore,
    };

UserStatisticsR _$UserStatisticsRFromJson(Map<String, dynamic> json) =>
    UserStatisticsR(
      apiKey: json['apiKey'] as String?,
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserStatisticsRToJson(UserStatisticsR instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'languages': instance.languages?.map((e) => e.toJson()).toList(),
    };

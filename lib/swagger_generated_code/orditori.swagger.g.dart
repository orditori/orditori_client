// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orditori.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotebookR _$NotebookRFromJson(Map<String, dynamic> json) => NotebookR(
      apiKey: json['apiKey'] as String,
      entries: (json['entries'] as List<dynamic>?)
              ?.map((e) => NotebookEntryR.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      formatVersion: json['formatVersion'] as int,
      id: json['id'] as int,
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$NotebookRToJson(NotebookR instance) => <String, dynamic>{
      'apiKey': instance.apiKey,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
      'formatVersion': instance.formatVersion,
      'id': instance.id,
      'revision': instance.revision,
    };

NotebookEntryR _$NotebookEntryRFromJson(Map<String, dynamic> json) =>
    NotebookEntryR(
      addedDate: json['addedDate'] as String,
      definitions: (json['definitions'] as List<dynamic>?)
              ?.map((e) =>
                  DefinitionContentItemR.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['id'] as int,
    );

Map<String, dynamic> _$NotebookEntryRToJson(NotebookEntryR instance) =>
    <String, dynamic>{
      'addedDate': instance.addedDate,
      'definitions': instance.definitions.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };

DefinitionContentItemR _$DefinitionContentItemRFromJson(
        Map<String, dynamic> json) =>
    DefinitionContentItemR(
      definition: json['definition'] as String,
      definitionSource: json['definitionSource'] as int,
      examples: (json['examples'] as List<dynamic>?)
              ?.map(
                  (e) => DefinitionExample.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['id'] as int,
      language: Language.fromJson(json['language'] as Map<String, dynamic>),
      partOfSpeech: partOfSpeechFromJson(json['partOfSpeech']),
      sourceLink: json['sourceLink'] as String,
      word: json['word'] as String,
    );

Map<String, dynamic> _$DefinitionContentItemRToJson(
        DefinitionContentItemR instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'definitionSource': instance.definitionSource,
      'examples': instance.examples.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'language': instance.language.toJson(),
      'partOfSpeech': partOfSpeechToJson(instance.partOfSpeech),
      'sourceLink': instance.sourceLink,
      'word': instance.word,
    };

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

DefinitionExample _$DefinitionExampleFromJson(Map<String, dynamic> json) =>
    DefinitionExample(
      definition: json['definition'] as int,
      id: json['id'] as int,
      $string: json['string'] as String,
      translation: json['translation'] as String?,
    );

Map<String, dynamic> _$DefinitionExampleToJson(DefinitionExample instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'id': instance.id,
      'string': instance.$string,
      'translation': instance.translation,
    };

NotebookEntryW _$NotebookEntryWFromJson(Map<String, dynamic> json) =>
    NotebookEntryW(
      addedDate: json['addedDate'] as String,
      notebook: json['notebook'] as int,
    );

Map<String, dynamic> _$NotebookEntryWToJson(NotebookEntryW instance) =>
    <String, dynamic>{
      'addedDate': instance.addedDate,
      'notebook': instance.notebook,
    };

DefinitionsWithSource _$DefinitionsWithSourceFromJson(
        Map<String, dynamic> json) =>
    DefinitionsWithSource(
      definitionSource: DefinitionSource.fromJson(
          json['definitionSource'] as Map<String, dynamic>),
      definitions: (json['definitions'] as List<dynamic>?)
              ?.map((e) => DefinitionR.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DefinitionsWithSourceToJson(
        DefinitionsWithSource instance) =>
    <String, dynamic>{
      'definitionSource': instance.definitionSource.toJson(),
      'definitions': instance.definitions.map((e) => e.toJson()).toList(),
    };

DefinitionR _$DefinitionRFromJson(Map<String, dynamic> json) => DefinitionR(
      definition: json['definition'] as String,
      examples: (json['examples'] as List<dynamic>?)
              ?.map(
                  (e) => DefinitionExample.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['id'] as int,
      language: Language.fromJson(json['language'] as Map<String, dynamic>),
      partOfSpeech: partOfSpeechFromJson(json['partOfSpeech']),
      sourceLink: json['sourceLink'] as String,
      word: json['word'] as String,
    );

Map<String, dynamic> _$DefinitionRToJson(DefinitionR instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'examples': instance.examples.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'language': instance.language.toJson(),
      'partOfSpeech': partOfSpeechToJson(instance.partOfSpeech),
      'sourceLink': instance.sourceLink,
      'word': instance.word,
    };

DefinitionSource _$DefinitionSourceFromJson(Map<String, dynamic> json) =>
    DefinitionSource(
      description: json['description'] as String,
      extractorRevision: json['extractorRevision'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      scrapeUrl: json['scrapeUrl'] as String,
    );

Map<String, dynamic> _$DefinitionSourceToJson(DefinitionSource instance) =>
    <String, dynamic>{
      'description': instance.description,
      'extractorRevision': instance.extractorRevision,
      'id': instance.id,
      'name': instance.name,
      'scrapeUrl': instance.scrapeUrl,
    };

DefinitionContentItemW _$DefinitionContentItemWFromJson(
        Map<String, dynamic> json) =>
    DefinitionContentItemW(
      definition: json['definition'] as int,
      entry: json['entry'] as int,
    );

Map<String, dynamic> _$DefinitionContentItemWToJson(
        DefinitionContentItemW instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'entry': instance.entry,
    };

DefinitionExerciseR _$DefinitionExerciseRFromJson(Map<String, dynamic> json) =>
    DefinitionExerciseR(
      definition: json['definition'] as String,
      difficultyScore: (json['difficultyScore'] as num).toDouble(),
      id: json['id'] as int,
      language: Language.fromJson(json['language'] as Map<String, dynamic>),
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$DefinitionExerciseRToJson(
        DefinitionExerciseR instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'difficultyScore': instance.difficultyScore,
      'id': instance.id,
      'language': instance.language.toJson(),
      'options': instance.options,
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
      actual: json['actual'] as String,
      expected: json['expected'] as String,
    );

Map<String, dynamic> _$FuzzyCompareIssueToJson(FuzzyCompareIssue instance) =>
    <String, dynamic>{
      'actual': instance.actual,
      'expected': instance.expected,
    };

ExerciseSolutionDefinitionExercise _$ExerciseSolutionDefinitionExerciseFromJson(
        Map<String, dynamic> json) =>
    ExerciseSolutionDefinitionExercise(
      exercise: json['exercise'] as int,
      input: json['input'] as String,
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
          correct: json['correct'] as int,
          definition:
              Definition.fromJson(json['definition'] as Map<String, dynamic>),
          difficultyScore: (json['difficultyScore'] as num).toDouble(),
          id: json['id'] as int,
          incorrect: json['incorrect'] as int,
        );

Map<String, dynamic> _$DefinitionExerciseStatsDefinitionExerciseToJson(
        DefinitionExerciseStatsDefinitionExercise instance) =>
    <String, dynamic>{
      'correct': instance.correct,
      'definition': instance.definition.toJson(),
      'difficultyScore': instance.difficultyScore,
      'id': instance.id,
      'incorrect': instance.incorrect,
    };

Definition _$DefinitionFromJson(Map<String, dynamic> json) => Definition(
      definition: json['definition'] as String,
      id: json['id'] as int,
      language: json['language'] as String,
      page: json['page'] as int,
      partOfSpeech: partOfSpeechFromJson(json['partOfSpeech']),
      sourceLink: json['sourceLink'] as String,
      word: json['word'] as String,
    );

Map<String, dynamic> _$DefinitionToJson(Definition instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'id': instance.id,
      'language': instance.language,
      'page': instance.page,
      'partOfSpeech': partOfSpeechToJson(instance.partOfSpeech),
      'sourceLink': instance.sourceLink,
      'word': instance.word,
    };

DefinitionExampleExerciseR _$DefinitionExampleExerciseRFromJson(
        Map<String, dynamic> json) =>
    DefinitionExampleExerciseR(
      definition: json['definition'] as String,
      difficultyScore: (json['difficultyScore'] as num).toDouble(),
      example: (json['example'] as List<dynamic>?)
              ?.map((e) => StringOrGap.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['id'] as int,
      language: Language.fromJson(json['language'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DefinitionExampleExerciseRToJson(
        DefinitionExampleExerciseR instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'difficultyScore': instance.difficultyScore,
      'example': instance.example.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'language': instance.language.toJson(),
    };

StringOrGap _$StringOrGapFromJson(Map<String, dynamic> json) => StringOrGap();

Map<String, dynamic> _$StringOrGapToJson(StringOrGap instance) =>
    <String, dynamic>{};

ExerciseSolutionDefinitionExampleExercise
    _$ExerciseSolutionDefinitionExampleExerciseFromJson(
            Map<String, dynamic> json) =>
        ExerciseSolutionDefinitionExampleExercise(
          exercise: json['exercise'] as int,
          input: json['input'] as String,
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
          correct: json['correct'] as int,
          definition:
              Definition.fromJson(json['definition'] as Map<String, dynamic>),
          difficultyScore: (json['difficultyScore'] as num).toDouble(),
          id: json['id'] as int,
          incorrect: json['incorrect'] as int,
        );

Map<String, dynamic> _$DefinitionExerciseStatsDefinitionExampleExerciseToJson(
        DefinitionExerciseStatsDefinitionExampleExercise instance) =>
    <String, dynamic>{
      'correct': instance.correct,
      'definition': instance.definition.toJson(),
      'difficultyScore': instance.difficultyScore,
      'id': instance.id,
      'incorrect': instance.incorrect,
    };

UserStatisticsR _$UserStatisticsRFromJson(Map<String, dynamic> json) =>
    UserStatisticsR(
      apiKey: json['apiKey'] as String,
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserStatisticsRToJson(UserStatisticsR instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'languages': instance.languages.map((e) => e.toJson()).toList(),
    };

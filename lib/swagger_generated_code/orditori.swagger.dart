import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

import 'package:chopper/chopper.dart';
import 'client_mapping.dart';
import 'package:chopper/chopper.dart' as chopper;

part 'orditori.swagger.chopper.dart';
part 'orditori.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Orditori extends ChopperService {
  static Orditori create({ChopperClient? client, String? baseUrl}) {
    if (client != null) {
      return _$Orditori(client);
    }

    final newClient = ChopperClient(
        services: [_$Orditori()],
        converter: $JsonSerializableConverter(),
        baseUrl: baseUrl ?? 'http://');
    return _$Orditori(newClient);
  }

  ///
  ///@param apiKey
  Future<chopper.Response<NotebookR>> notebooksGet({required String? apiKey}) {
    generatedMapping.putIfAbsent(NotebookR, () => NotebookR.fromJsonFactory);

    return _notebooksGet(apiKey: apiKey);
  }

  ///
  ///@param apiKey
  @Get(path: '/notebooks')
  Future<chopper.Response<NotebookR>> _notebooksGet(
      {@Query('apiKey') required String? apiKey});

  ///
  ///@param apiKey
  Future<chopper.Response<int>> notebookEntriesPost(
      {required String? apiKey, required NotebookEntryW? body}) {
    return _notebookEntriesPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  @Post(path: '/notebookEntries')
  Future<chopper.Response<int>> _notebookEntriesPost(
      {@Query('apiKey') required String? apiKey,
      @Body() required NotebookEntryW? body});

  ///
  ///@param apiKey
  ///@param entryId
  Future<chopper.Response> notebookEntriesEntryIdDelete(
      {required String? apiKey, required int? entryId}) {
    return _notebookEntriesEntryIdDelete(apiKey: apiKey, entryId: entryId);
  }

  ///
  ///@param apiKey
  ///@param entryId
  @Delete(path: '/notebookEntries/{entryId}')
  Future<chopper.Response> _notebookEntriesEntryIdDelete(
      {@Query('apiKey') required String? apiKey,
      @Path('entryId') required int? entryId});

  ///
  ///@param query
  Future<chopper.Response<List<DefinitionsWithSource>>> definitionsGet(
      {required String? query}) {
    generatedMapping.putIfAbsent(
        DefinitionsWithSource, () => DefinitionsWithSource.fromJsonFactory);

    return _definitionsGet(query: query);
  }

  ///
  ///@param query
  @Get(path: '/definitions')
  Future<chopper.Response<List<DefinitionsWithSource>>> _definitionsGet(
      {@Query('query') required String? query});

  ///
  ///@param apiKey
  Future<chopper.Response<int>> definitionExamplesPost(
      {required String? apiKey, required DefinitionExampleW? body}) {
    return _definitionExamplesPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  @Post(path: '/definitionExamples')
  Future<chopper.Response<int>> _definitionExamplesPost(
      {@Query('apiKey') required String? apiKey,
      @Body() required DefinitionExampleW? body});

  ///
  ///@param apiKey
  Future<chopper.Response<int>> definitionContentItemsPost(
      {required String? apiKey, required DefinitionContentItemW? body}) {
    return _definitionContentItemsPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  @Post(path: '/definitionContentItems')
  Future<chopper.Response<int>> _definitionContentItemsPost(
      {@Query('apiKey') required String? apiKey,
      @Body() required DefinitionContentItemW? body});

  ///
  ///@param apiKey
  ///@param language
  Future<chopper.Response<DefinitionExerciseR>> exercisesDefinitionRandomGet(
      {required String? apiKey, String? language}) {
    generatedMapping.putIfAbsent(
        DefinitionExerciseR, () => DefinitionExerciseR.fromJsonFactory);

    return _exercisesDefinitionRandomGet(apiKey: apiKey, language: language);
  }

  ///
  ///@param apiKey
  ///@param language
  @Get(path: '/exercises/definition/random')
  Future<chopper.Response<DefinitionExerciseR>> _exercisesDefinitionRandomGet(
      {@Query('apiKey') required String? apiKey,
      @Query('language') String? language});

  ///
  ///@param apiKey
  Future<chopper.Response<SolutionCheckResult>>
      exercisesDefinitionSolutionsPost(
          {required String? apiKey,
          required ExerciseSolutionDefinitionExercise? body}) {
    generatedMapping.putIfAbsent(
        SolutionCheckResult, () => SolutionCheckResult.fromJsonFactory);

    return _exercisesDefinitionSolutionsPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  @Post(path: '/exercises/definition/solutions')
  Future<chopper.Response<SolutionCheckResult>>
      _exercisesDefinitionSolutionsPost(
          {@Query('apiKey') required String? apiKey,
          @Body() required ExerciseSolutionDefinitionExercise? body});

  ///
  ///@param apiKey
  Future<chopper.Response<List<DefinitionExerciseStatsDefinitionExercise>>>
      exercisesDefinitionScoresGet({required String? apiKey}) {
    generatedMapping.putIfAbsent(DefinitionExerciseStatsDefinitionExercise,
        () => DefinitionExerciseStatsDefinitionExercise.fromJsonFactory);

    return _exercisesDefinitionScoresGet(apiKey: apiKey);
  }

  ///
  ///@param apiKey
  @Get(path: '/exercises/definition/scores')
  Future<chopper.Response<List<DefinitionExerciseStatsDefinitionExercise>>>
      _exercisesDefinitionScoresGet({@Query('apiKey') required String? apiKey});

  ///
  ///@param apiKey
  Future<chopper.Response<DefinitionExampleExerciseR>>
      exercisesExampleRandomGet({required String? apiKey}) {
    generatedMapping.putIfAbsent(DefinitionExampleExerciseR,
        () => DefinitionExampleExerciseR.fromJsonFactory);

    return _exercisesExampleRandomGet(apiKey: apiKey);
  }

  ///
  ///@param apiKey
  @Get(path: '/exercises/example/random')
  Future<chopper.Response<DefinitionExampleExerciseR>>
      _exercisesExampleRandomGet({@Query('apiKey') required String? apiKey});

  ///
  ///@param apiKey
  Future<chopper.Response<SolutionCheckResult>> exercisesExampleSolutionsPost(
      {required String? apiKey,
      required ExerciseSolutionDefinitionExampleExercise? body}) {
    generatedMapping.putIfAbsent(
        SolutionCheckResult, () => SolutionCheckResult.fromJsonFactory);

    return _exercisesExampleSolutionsPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  @Post(path: '/exercises/example/solutions')
  Future<chopper.Response<SolutionCheckResult>> _exercisesExampleSolutionsPost(
      {@Query('apiKey') required String? apiKey,
      @Body() required ExerciseSolutionDefinitionExampleExercise? body});

  ///
  ///@param apiKey
  Future<
          chopper
              .Response<List<DefinitionExerciseStatsDefinitionExampleExercise>>>
      exercisesExampleScoresGet({required String? apiKey}) {
    generatedMapping.putIfAbsent(
        DefinitionExerciseStatsDefinitionExampleExercise,
        () => DefinitionExerciseStatsDefinitionExampleExercise.fromJsonFactory);

    return _exercisesExampleScoresGet(apiKey: apiKey);
  }

  ///
  ///@param apiKey
  @Get(path: '/exercises/example/scores')
  Future<
          chopper
              .Response<List<DefinitionExerciseStatsDefinitionExampleExercise>>>
      _exercisesExampleScoresGet({@Query('apiKey') required String? apiKey});

  ///
  ///@param apiKey
  Future<chopper.Response<UserStatisticsR>> userStatisticsGet(
      {required String? apiKey}) {
    generatedMapping.putIfAbsent(
        UserStatisticsR, () => UserStatisticsR.fromJsonFactory);

    return _userStatisticsGet(apiKey: apiKey);
  }

  ///
  ///@param apiKey
  @Get(path: '/userStatistics')
  Future<chopper.Response<UserStatisticsR>> _userStatisticsGet(
      {@Query('apiKey') required String? apiKey});
}

@JsonSerializable(explicitToJson: true)
class NotebookR {
  NotebookR({
    this.entries,
    this.id,
    this.revision,
    this.apiKey,
    this.formatVersion,
  });

  factory NotebookR.fromJson(Map<String, dynamic> json) =>
      _$NotebookRFromJson(json);

  @JsonKey(name: 'entries', defaultValue: <NotebookEntryR>[])
  final List<NotebookEntryR>? entries;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'revision')
  final int? revision;
  @JsonKey(name: 'apiKey')
  final String? apiKey;
  @JsonKey(name: 'formatVersion')
  final int? formatVersion;
  static const fromJsonFactory = _$NotebookRFromJson;
  static const toJsonFactory = _$NotebookRToJson;
  Map<String, dynamic> toJson() => _$NotebookRToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotebookR &&
            (identical(other.entries, entries) ||
                const DeepCollectionEquality()
                    .equals(other.entries, entries)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.revision, revision) ||
                const DeepCollectionEquality()
                    .equals(other.revision, revision)) &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.formatVersion, formatVersion) ||
                const DeepCollectionEquality()
                    .equals(other.formatVersion, formatVersion)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(entries) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(revision) ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(formatVersion) ^
      runtimeType.hashCode;
}

extension $NotebookRExtension on NotebookR {
  NotebookR copyWith(
      {List<NotebookEntryR>? entries,
      int? id,
      int? revision,
      String? apiKey,
      int? formatVersion}) {
    return NotebookR(
        entries: entries ?? this.entries,
        id: id ?? this.id,
        revision: revision ?? this.revision,
        apiKey: apiKey ?? this.apiKey,
        formatVersion: formatVersion ?? this.formatVersion);
  }
}

@JsonSerializable(explicitToJson: true)
class NotebookEntryR {
  NotebookEntryR({
    this.addedDate,
    this.id,
    this.definitions,
  });

  factory NotebookEntryR.fromJson(Map<String, dynamic> json) =>
      _$NotebookEntryRFromJson(json);

  @JsonKey(name: 'addedDate')
  final String? addedDate;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'definitions', defaultValue: <DefinitionContentItemR>[])
  final List<DefinitionContentItemR>? definitions;
  static const fromJsonFactory = _$NotebookEntryRFromJson;
  static const toJsonFactory = _$NotebookEntryRToJson;
  Map<String, dynamic> toJson() => _$NotebookEntryRToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotebookEntryR &&
            (identical(other.addedDate, addedDate) ||
                const DeepCollectionEquality()
                    .equals(other.addedDate, addedDate)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.definitions, definitions) ||
                const DeepCollectionEquality()
                    .equals(other.definitions, definitions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(addedDate) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(definitions) ^
      runtimeType.hashCode;
}

extension $NotebookEntryRExtension on NotebookEntryR {
  NotebookEntryR copyWith(
      {String? addedDate, int? id, List<DefinitionContentItemR>? definitions}) {
    return NotebookEntryR(
        addedDate: addedDate ?? this.addedDate,
        id: id ?? this.id,
        definitions: definitions ?? this.definitions);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionContentItemR {
  DefinitionContentItemR({
    this.language,
    this.id,
    this.sourceLink,
    this.definitionSource,
    this.word,
    this.definition,
    this.examples,
  });

  factory DefinitionContentItemR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionContentItemRFromJson(json);

  @JsonKey(name: 'language')
  final Language? language;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'sourceLink')
  final String? sourceLink;
  @JsonKey(name: 'definitionSource')
  final int? definitionSource;
  @JsonKey(name: 'word')
  final String? word;
  @JsonKey(name: 'definition')
  final String? definition;
  @JsonKey(name: 'examples', defaultValue: <DefinitionExample>[])
  final List<DefinitionExample>? examples;
  static const fromJsonFactory = _$DefinitionContentItemRFromJson;
  static const toJsonFactory = _$DefinitionContentItemRToJson;
  Map<String, dynamic> toJson() => _$DefinitionContentItemRToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionContentItemR &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.sourceLink, sourceLink) ||
                const DeepCollectionEquality()
                    .equals(other.sourceLink, sourceLink)) &&
            (identical(other.definitionSource, definitionSource) ||
                const DeepCollectionEquality()
                    .equals(other.definitionSource, definitionSource)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.examples, examples) ||
                const DeepCollectionEquality()
                    .equals(other.examples, examples)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(sourceLink) ^
      const DeepCollectionEquality().hash(definitionSource) ^
      const DeepCollectionEquality().hash(word) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(examples) ^
      runtimeType.hashCode;
}

extension $DefinitionContentItemRExtension on DefinitionContentItemR {
  DefinitionContentItemR copyWith(
      {Language? language,
      int? id,
      String? sourceLink,
      int? definitionSource,
      String? word,
      String? definition,
      List<DefinitionExample>? examples}) {
    return DefinitionContentItemR(
        language: language ?? this.language,
        id: id ?? this.id,
        sourceLink: sourceLink ?? this.sourceLink,
        definitionSource: definitionSource ?? this.definitionSource,
        word: word ?? this.word,
        definition: definition ?? this.definition,
        examples: examples ?? this.examples);
  }
}

@JsonSerializable(explicitToJson: true)
class Language {
  Language({
    this.name,
    this.code,
  });

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  static const fromJsonFactory = _$LanguageFromJson;
  static const toJsonFactory = _$LanguageToJson;
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Language &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(code) ^
      runtimeType.hashCode;
}

extension $LanguageExtension on Language {
  Language copyWith({String? name, String? code}) {
    return Language(name: name ?? this.name, code: code ?? this.code);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExample {
  DefinitionExample({
    this.id,
    this.translation,
    this.definition,
    this.$String,
  });

  factory DefinitionExample.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExampleFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'translation')
  final String? translation;
  @JsonKey(name: 'definition')
  final int? definition;
  @JsonKey(name: 'string')
  final String? $String;
  static const fromJsonFactory = _$DefinitionExampleFromJson;
  static const toJsonFactory = _$DefinitionExampleToJson;
  Map<String, dynamic> toJson() => _$DefinitionExampleToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExample &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.$String, $String) ||
                const DeepCollectionEquality().equals(other.$String, $String)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(translation) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash($String) ^
      runtimeType.hashCode;
}

extension $DefinitionExampleExtension on DefinitionExample {
  DefinitionExample copyWith(
      {int? id, String? translation, int? definition, String? $String}) {
    return DefinitionExample(
        id: id ?? this.id,
        translation: translation ?? this.translation,
        definition: definition ?? this.definition,
        $String: $String ?? this.$String);
  }
}

@JsonSerializable(explicitToJson: true)
class NotebookEntryW {
  NotebookEntryW({
    this.addedDate,
    this.notebook,
  });

  factory NotebookEntryW.fromJson(Map<String, dynamic> json) =>
      _$NotebookEntryWFromJson(json);

  @JsonKey(name: 'addedDate')
  final String? addedDate;
  @JsonKey(name: 'notebook')
  final int? notebook;
  static const fromJsonFactory = _$NotebookEntryWFromJson;
  static const toJsonFactory = _$NotebookEntryWToJson;
  Map<String, dynamic> toJson() => _$NotebookEntryWToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotebookEntryW &&
            (identical(other.addedDate, addedDate) ||
                const DeepCollectionEquality()
                    .equals(other.addedDate, addedDate)) &&
            (identical(other.notebook, notebook) ||
                const DeepCollectionEquality()
                    .equals(other.notebook, notebook)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(addedDate) ^
      const DeepCollectionEquality().hash(notebook) ^
      runtimeType.hashCode;
}

extension $NotebookEntryWExtension on NotebookEntryW {
  NotebookEntryW copyWith({String? addedDate, int? notebook}) {
    return NotebookEntryW(
        addedDate: addedDate ?? this.addedDate,
        notebook: notebook ?? this.notebook);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionsWithSource {
  DefinitionsWithSource({
    this.definitionSource,
    this.definitions,
  });

  factory DefinitionsWithSource.fromJson(Map<String, dynamic> json) =>
      _$DefinitionsWithSourceFromJson(json);

  @JsonKey(name: 'definitionSource')
  final DefinitionSource? definitionSource;
  @JsonKey(name: 'definitions', defaultValue: <Definition>[])
  final List<Definition>? definitions;
  static const fromJsonFactory = _$DefinitionsWithSourceFromJson;
  static const toJsonFactory = _$DefinitionsWithSourceToJson;
  Map<String, dynamic> toJson() => _$DefinitionsWithSourceToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionsWithSource &&
            (identical(other.definitionSource, definitionSource) ||
                const DeepCollectionEquality()
                    .equals(other.definitionSource, definitionSource)) &&
            (identical(other.definitions, definitions) ||
                const DeepCollectionEquality()
                    .equals(other.definitions, definitions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definitionSource) ^
      const DeepCollectionEquality().hash(definitions) ^
      runtimeType.hashCode;
}

extension $DefinitionsWithSourceExtension on DefinitionsWithSource {
  DefinitionsWithSource copyWith(
      {DefinitionSource? definitionSource, List<Definition>? definitions}) {
    return DefinitionsWithSource(
        definitionSource: definitionSource ?? this.definitionSource,
        definitions: definitions ?? this.definitions);
  }
}

@JsonSerializable(explicitToJson: true)
class Definition {
  Definition({
    this.language,
    this.sourceLink,
    this.word,
    this.definition,
    this.examples,
  });

  factory Definition.fromJson(Map<String, dynamic> json) =>
      _$DefinitionFromJson(json);

  @JsonKey(name: 'language')
  final Language? language;
  @JsonKey(name: 'sourceLink')
  final String? sourceLink;
  @JsonKey(name: 'word')
  final String? word;
  @JsonKey(name: 'definition')
  final String? definition;
  @JsonKey(name: 'examples', defaultValue: <Example>[])
  final List<Example>? examples;
  static const fromJsonFactory = _$DefinitionFromJson;
  static const toJsonFactory = _$DefinitionToJson;
  Map<String, dynamic> toJson() => _$DefinitionToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Definition &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.sourceLink, sourceLink) ||
                const DeepCollectionEquality()
                    .equals(other.sourceLink, sourceLink)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.examples, examples) ||
                const DeepCollectionEquality()
                    .equals(other.examples, examples)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(sourceLink) ^
      const DeepCollectionEquality().hash(word) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(examples) ^
      runtimeType.hashCode;
}

extension $DefinitionExtension on Definition {
  Definition copyWith(
      {Language? language,
      String? sourceLink,
      String? word,
      String? definition,
      List<Example>? examples}) {
    return Definition(
        language: language ?? this.language,
        sourceLink: sourceLink ?? this.sourceLink,
        word: word ?? this.word,
        definition: definition ?? this.definition,
        examples: examples ?? this.examples);
  }
}

@JsonSerializable(explicitToJson: true)
class Example {
  Example({
    this.translation,
    this.$String,
  });

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  @JsonKey(name: 'translation')
  final String? translation;
  @JsonKey(name: 'string')
  final String? $String;
  static const fromJsonFactory = _$ExampleFromJson;
  static const toJsonFactory = _$ExampleToJson;
  Map<String, dynamic> toJson() => _$ExampleToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Example &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)) &&
            (identical(other.$String, $String) ||
                const DeepCollectionEquality().equals(other.$String, $String)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(translation) ^
      const DeepCollectionEquality().hash($String) ^
      runtimeType.hashCode;
}

extension $ExampleExtension on Example {
  Example copyWith({String? translation, String? $String}) {
    return Example(
        translation: translation ?? this.translation,
        $String: $String ?? this.$String);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionSource {
  DefinitionSource({
    this.name,
    this.id,
    this.scrapeUrl,
    this.description,
  });

  factory DefinitionSource.fromJson(Map<String, dynamic> json) =>
      _$DefinitionSourceFromJson(json);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'scrapeUrl')
  final String? scrapeUrl;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$DefinitionSourceFromJson;
  static const toJsonFactory = _$DefinitionSourceToJson;
  Map<String, dynamic> toJson() => _$DefinitionSourceToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionSource &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.scrapeUrl, scrapeUrl) ||
                const DeepCollectionEquality()
                    .equals(other.scrapeUrl, scrapeUrl)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(scrapeUrl) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $DefinitionSourceExtension on DefinitionSource {
  DefinitionSource copyWith(
      {String? name, int? id, String? scrapeUrl, String? description}) {
    return DefinitionSource(
        name: name ?? this.name,
        id: id ?? this.id,
        scrapeUrl: scrapeUrl ?? this.scrapeUrl,
        description: description ?? this.description);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExampleW {
  DefinitionExampleW({
    this.translation,
    this.definition,
    this.$String,
  });

  factory DefinitionExampleW.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExampleWFromJson(json);

  @JsonKey(name: 'translation')
  final String? translation;
  @JsonKey(name: 'definition')
  final int? definition;
  @JsonKey(name: 'string')
  final String? $String;
  static const fromJsonFactory = _$DefinitionExampleWFromJson;
  static const toJsonFactory = _$DefinitionExampleWToJson;
  Map<String, dynamic> toJson() => _$DefinitionExampleWToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExampleW &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.$String, $String) ||
                const DeepCollectionEquality().equals(other.$String, $String)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(translation) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash($String) ^
      runtimeType.hashCode;
}

extension $DefinitionExampleWExtension on DefinitionExampleW {
  DefinitionExampleW copyWith(
      {String? translation, int? definition, String? $String}) {
    return DefinitionExampleW(
        translation: translation ?? this.translation,
        definition: definition ?? this.definition,
        $String: $String ?? this.$String);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionContentItemW {
  DefinitionContentItemW({
    this.language,
    this.sourceLink,
    this.definitionSource,
    this.word,
    this.definition,
    this.entry,
  });

  factory DefinitionContentItemW.fromJson(Map<String, dynamic> json) =>
      _$DefinitionContentItemWFromJson(json);

  @JsonKey(name: 'language')
  final Language? language;
  @JsonKey(name: 'sourceLink')
  final String? sourceLink;
  @JsonKey(name: 'definitionSource')
  final int? definitionSource;
  @JsonKey(name: 'word')
  final String? word;
  @JsonKey(name: 'definition')
  final String? definition;
  @JsonKey(name: 'entry')
  final int? entry;
  static const fromJsonFactory = _$DefinitionContentItemWFromJson;
  static const toJsonFactory = _$DefinitionContentItemWToJson;
  Map<String, dynamic> toJson() => _$DefinitionContentItemWToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionContentItemW &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.sourceLink, sourceLink) ||
                const DeepCollectionEquality()
                    .equals(other.sourceLink, sourceLink)) &&
            (identical(other.definitionSource, definitionSource) ||
                const DeepCollectionEquality()
                    .equals(other.definitionSource, definitionSource)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.entry, entry) ||
                const DeepCollectionEquality().equals(other.entry, entry)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(sourceLink) ^
      const DeepCollectionEquality().hash(definitionSource) ^
      const DeepCollectionEquality().hash(word) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(entry) ^
      runtimeType.hashCode;
}

extension $DefinitionContentItemWExtension on DefinitionContentItemW {
  DefinitionContentItemW copyWith(
      {Language? language,
      String? sourceLink,
      int? definitionSource,
      String? word,
      String? definition,
      int? entry}) {
    return DefinitionContentItemW(
        language: language ?? this.language,
        sourceLink: sourceLink ?? this.sourceLink,
        definitionSource: definitionSource ?? this.definitionSource,
        word: word ?? this.word,
        definition: definition ?? this.definition,
        entry: entry ?? this.entry);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExerciseR {
  DefinitionExerciseR({
    this.language,
    this.id,
    this.definition,
    this.difficultyScore,
  });

  factory DefinitionExerciseR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExerciseRFromJson(json);

  @JsonKey(name: 'language')
  final Language? language;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'definition')
  final String? definition;
  @JsonKey(name: 'difficultyScore')
  final double? difficultyScore;
  static const fromJsonFactory = _$DefinitionExerciseRFromJson;
  static const toJsonFactory = _$DefinitionExerciseRToJson;
  Map<String, dynamic> toJson() => _$DefinitionExerciseRToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExerciseR &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      runtimeType.hashCode;
}

extension $DefinitionExerciseRExtension on DefinitionExerciseR {
  DefinitionExerciseR copyWith(
      {Language? language,
      int? id,
      String? definition,
      double? difficultyScore}) {
    return DefinitionExerciseR(
        language: language ?? this.language,
        id: id ?? this.id,
        definition: definition ?? this.definition,
        difficultyScore: difficultyScore ?? this.difficultyScore);
  }
}

@JsonSerializable(explicitToJson: true)
class SolutionCheckResult {
  SolutionCheckResult();

  factory SolutionCheckResult.fromJson(Map<String, dynamic> json) =>
      _$SolutionCheckResultFromJson(json);

  static const fromJsonFactory = _$SolutionCheckResultFromJson;
  static const toJsonFactory = _$SolutionCheckResultToJson;
  Map<String, dynamic> toJson() => _$SolutionCheckResultToJson(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class FuzzyCompareToken {
  FuzzyCompareToken();

  factory FuzzyCompareToken.fromJson(Map<String, dynamic> json) =>
      _$FuzzyCompareTokenFromJson(json);

  static const fromJsonFactory = _$FuzzyCompareTokenFromJson;
  static const toJsonFactory = _$FuzzyCompareTokenToJson;
  Map<String, dynamic> toJson() => _$FuzzyCompareTokenToJson(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class FuzzyCompareIssue {
  FuzzyCompareIssue({
    this.expected,
    this.actual,
  });

  factory FuzzyCompareIssue.fromJson(Map<String, dynamic> json) =>
      _$FuzzyCompareIssueFromJson(json);

  @JsonKey(name: 'expected')
  final String? expected;
  @JsonKey(name: 'actual')
  final String? actual;
  static const fromJsonFactory = _$FuzzyCompareIssueFromJson;
  static const toJsonFactory = _$FuzzyCompareIssueToJson;
  Map<String, dynamic> toJson() => _$FuzzyCompareIssueToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FuzzyCompareIssue &&
            (identical(other.expected, expected) ||
                const DeepCollectionEquality()
                    .equals(other.expected, expected)) &&
            (identical(other.actual, actual) ||
                const DeepCollectionEquality().equals(other.actual, actual)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(expected) ^
      const DeepCollectionEquality().hash(actual) ^
      runtimeType.hashCode;
}

extension $FuzzyCompareIssueExtension on FuzzyCompareIssue {
  FuzzyCompareIssue copyWith({String? expected, String? actual}) {
    return FuzzyCompareIssue(
        expected: expected ?? this.expected, actual: actual ?? this.actual);
  }
}

@JsonSerializable(explicitToJson: true)
class ExerciseSolutionDefinitionExercise {
  ExerciseSolutionDefinitionExercise({
    this.exercise,
    this.input,
  });

  factory ExerciseSolutionDefinitionExercise.fromJson(
          Map<String, dynamic> json) =>
      _$ExerciseSolutionDefinitionExerciseFromJson(json);

  @JsonKey(name: 'exercise')
  final int? exercise;
  @JsonKey(name: 'input')
  final String? input;
  static const fromJsonFactory = _$ExerciseSolutionDefinitionExerciseFromJson;
  static const toJsonFactory = _$ExerciseSolutionDefinitionExerciseToJson;
  Map<String, dynamic> toJson() =>
      _$ExerciseSolutionDefinitionExerciseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ExerciseSolutionDefinitionExercise &&
            (identical(other.exercise, exercise) ||
                const DeepCollectionEquality()
                    .equals(other.exercise, exercise)) &&
            (identical(other.input, input) ||
                const DeepCollectionEquality().equals(other.input, input)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(exercise) ^
      const DeepCollectionEquality().hash(input) ^
      runtimeType.hashCode;
}

extension $ExerciseSolutionDefinitionExerciseExtension
    on ExerciseSolutionDefinitionExercise {
  ExerciseSolutionDefinitionExercise copyWith({int? exercise, String? input}) {
    return ExerciseSolutionDefinitionExercise(
        exercise: exercise ?? this.exercise, input: input ?? this.input);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExerciseStatsDefinitionExercise {
  DefinitionExerciseStatsDefinitionExercise({
    this.correct,
    this.id,
    this.incorrect,
    this.definition,
    this.difficultyScore,
  });

  factory DefinitionExerciseStatsDefinitionExercise.fromJson(
          Map<String, dynamic> json) =>
      _$DefinitionExerciseStatsDefinitionExerciseFromJson(json);

  @JsonKey(name: 'correct')
  final int? correct;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'incorrect')
  final int? incorrect;
  @JsonKey(name: 'definition')
  final DefinitionContentItem? definition;
  @JsonKey(name: 'difficultyScore')
  final double? difficultyScore;
  static const fromJsonFactory =
      _$DefinitionExerciseStatsDefinitionExerciseFromJson;
  static const toJsonFactory =
      _$DefinitionExerciseStatsDefinitionExerciseToJson;
  Map<String, dynamic> toJson() =>
      _$DefinitionExerciseStatsDefinitionExerciseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExerciseStatsDefinitionExercise &&
            (identical(other.correct, correct) ||
                const DeepCollectionEquality()
                    .equals(other.correct, correct)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.incorrect, incorrect) ||
                const DeepCollectionEquality()
                    .equals(other.incorrect, incorrect)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(correct) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(incorrect) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      runtimeType.hashCode;
}

extension $DefinitionExerciseStatsDefinitionExerciseExtension
    on DefinitionExerciseStatsDefinitionExercise {
  DefinitionExerciseStatsDefinitionExercise copyWith(
      {int? correct,
      int? id,
      int? incorrect,
      DefinitionContentItem? definition,
      double? difficultyScore}) {
    return DefinitionExerciseStatsDefinitionExercise(
        correct: correct ?? this.correct,
        id: id ?? this.id,
        incorrect: incorrect ?? this.incorrect,
        definition: definition ?? this.definition,
        difficultyScore: difficultyScore ?? this.difficultyScore);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionContentItem {
  DefinitionContentItem({
    this.language,
    this.id,
    this.sourceLink,
    this.definitionSource,
    this.word,
    this.definition,
    this.entry,
  });

  factory DefinitionContentItem.fromJson(Map<String, dynamic> json) =>
      _$DefinitionContentItemFromJson(json);

  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'sourceLink')
  final String? sourceLink;
  @JsonKey(name: 'definitionSource')
  final int? definitionSource;
  @JsonKey(name: 'word')
  final String? word;
  @JsonKey(name: 'definition')
  final String? definition;
  @JsonKey(name: 'entry')
  final int? entry;
  static const fromJsonFactory = _$DefinitionContentItemFromJson;
  static const toJsonFactory = _$DefinitionContentItemToJson;
  Map<String, dynamic> toJson() => _$DefinitionContentItemToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionContentItem &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.sourceLink, sourceLink) ||
                const DeepCollectionEquality()
                    .equals(other.sourceLink, sourceLink)) &&
            (identical(other.definitionSource, definitionSource) ||
                const DeepCollectionEquality()
                    .equals(other.definitionSource, definitionSource)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.entry, entry) ||
                const DeepCollectionEquality().equals(other.entry, entry)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(sourceLink) ^
      const DeepCollectionEquality().hash(definitionSource) ^
      const DeepCollectionEquality().hash(word) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(entry) ^
      runtimeType.hashCode;
}

extension $DefinitionContentItemExtension on DefinitionContentItem {
  DefinitionContentItem copyWith(
      {String? language,
      int? id,
      String? sourceLink,
      int? definitionSource,
      String? word,
      String? definition,
      int? entry}) {
    return DefinitionContentItem(
        language: language ?? this.language,
        id: id ?? this.id,
        sourceLink: sourceLink ?? this.sourceLink,
        definitionSource: definitionSource ?? this.definitionSource,
        word: word ?? this.word,
        definition: definition ?? this.definition,
        entry: entry ?? this.entry);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExampleExerciseR {
  DefinitionExampleExerciseR({
    this.language,
    this.id,
    this.definition,
    this.example,
    this.difficultyScore,
  });

  factory DefinitionExampleExerciseR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExampleExerciseRFromJson(json);

  @JsonKey(name: 'language')
  final Language? language;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'definition')
  final String? definition;
  @JsonKey(name: 'example', defaultValue: <StringOrGap>[])
  final List<StringOrGap>? example;
  @JsonKey(name: 'difficultyScore')
  final double? difficultyScore;
  static const fromJsonFactory = _$DefinitionExampleExerciseRFromJson;
  static const toJsonFactory = _$DefinitionExampleExerciseRToJson;
  Map<String, dynamic> toJson() => _$DefinitionExampleExerciseRToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExampleExerciseR &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.example, example) ||
                const DeepCollectionEquality()
                    .equals(other.example, example)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(example) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      runtimeType.hashCode;
}

extension $DefinitionExampleExerciseRExtension on DefinitionExampleExerciseR {
  DefinitionExampleExerciseR copyWith(
      {Language? language,
      int? id,
      String? definition,
      List<StringOrGap>? example,
      double? difficultyScore}) {
    return DefinitionExampleExerciseR(
        language: language ?? this.language,
        id: id ?? this.id,
        definition: definition ?? this.definition,
        example: example ?? this.example,
        difficultyScore: difficultyScore ?? this.difficultyScore);
  }
}

@JsonSerializable(explicitToJson: true)
class StringOrGap {
  StringOrGap();

  factory StringOrGap.fromJson(Map<String, dynamic> json) =>
      _$StringOrGapFromJson(json);

  static const fromJsonFactory = _$StringOrGapFromJson;
  static const toJsonFactory = _$StringOrGapToJson;
  Map<String, dynamic> toJson() => _$StringOrGapToJson(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class ExerciseSolutionDefinitionExampleExercise {
  ExerciseSolutionDefinitionExampleExercise({
    this.exercise,
    this.input,
  });

  factory ExerciseSolutionDefinitionExampleExercise.fromJson(
          Map<String, dynamic> json) =>
      _$ExerciseSolutionDefinitionExampleExerciseFromJson(json);

  @JsonKey(name: 'exercise')
  final int? exercise;
  @JsonKey(name: 'input')
  final String? input;
  static const fromJsonFactory =
      _$ExerciseSolutionDefinitionExampleExerciseFromJson;
  static const toJsonFactory =
      _$ExerciseSolutionDefinitionExampleExerciseToJson;
  Map<String, dynamic> toJson() =>
      _$ExerciseSolutionDefinitionExampleExerciseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ExerciseSolutionDefinitionExampleExercise &&
            (identical(other.exercise, exercise) ||
                const DeepCollectionEquality()
                    .equals(other.exercise, exercise)) &&
            (identical(other.input, input) ||
                const DeepCollectionEquality().equals(other.input, input)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(exercise) ^
      const DeepCollectionEquality().hash(input) ^
      runtimeType.hashCode;
}

extension $ExerciseSolutionDefinitionExampleExerciseExtension
    on ExerciseSolutionDefinitionExampleExercise {
  ExerciseSolutionDefinitionExampleExercise copyWith(
      {int? exercise, String? input}) {
    return ExerciseSolutionDefinitionExampleExercise(
        exercise: exercise ?? this.exercise, input: input ?? this.input);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExerciseStatsDefinitionExampleExercise {
  DefinitionExerciseStatsDefinitionExampleExercise({
    this.correct,
    this.id,
    this.incorrect,
    this.definition,
    this.difficultyScore,
  });

  factory DefinitionExerciseStatsDefinitionExampleExercise.fromJson(
          Map<String, dynamic> json) =>
      _$DefinitionExerciseStatsDefinitionExampleExerciseFromJson(json);

  @JsonKey(name: 'correct')
  final int? correct;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'incorrect')
  final int? incorrect;
  @JsonKey(name: 'definition')
  final DefinitionContentItem? definition;
  @JsonKey(name: 'difficultyScore')
  final double? difficultyScore;
  static const fromJsonFactory =
      _$DefinitionExerciseStatsDefinitionExampleExerciseFromJson;
  static const toJsonFactory =
      _$DefinitionExerciseStatsDefinitionExampleExerciseToJson;
  Map<String, dynamic> toJson() =>
      _$DefinitionExerciseStatsDefinitionExampleExerciseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExerciseStatsDefinitionExampleExercise &&
            (identical(other.correct, correct) ||
                const DeepCollectionEquality()
                    .equals(other.correct, correct)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.incorrect, incorrect) ||
                const DeepCollectionEquality()
                    .equals(other.incorrect, incorrect)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(correct) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(incorrect) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      runtimeType.hashCode;
}

extension $DefinitionExerciseStatsDefinitionExampleExerciseExtension
    on DefinitionExerciseStatsDefinitionExampleExercise {
  DefinitionExerciseStatsDefinitionExampleExercise copyWith(
      {int? correct,
      int? id,
      int? incorrect,
      DefinitionContentItem? definition,
      double? difficultyScore}) {
    return DefinitionExerciseStatsDefinitionExampleExercise(
        correct: correct ?? this.correct,
        id: id ?? this.id,
        incorrect: incorrect ?? this.incorrect,
        definition: definition ?? this.definition,
        difficultyScore: difficultyScore ?? this.difficultyScore);
  }
}

@JsonSerializable(explicitToJson: true)
class UserStatisticsR {
  UserStatisticsR({
    this.apiKey,
    this.languages,
  });

  factory UserStatisticsR.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticsRFromJson(json);

  @JsonKey(name: 'apiKey')
  final String? apiKey;
  @JsonKey(name: 'languages', defaultValue: <Language>[])
  final List<Language>? languages;
  static const fromJsonFactory = _$UserStatisticsRFromJson;
  static const toJsonFactory = _$UserStatisticsRToJson;
  Map<String, dynamic> toJson() => _$UserStatisticsRToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserStatisticsR &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.languages, languages) ||
                const DeepCollectionEquality()
                    .equals(other.languages, languages)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(languages) ^
      runtimeType.hashCode;
}

extension $UserStatisticsRExtension on UserStatisticsR {
  UserStatisticsR copyWith({String? apiKey, List<Language>? languages}) {
    return UserStatisticsR(
        apiKey: apiKey ?? this.apiKey, languages: languages ?? this.languages);
  }
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(
      chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

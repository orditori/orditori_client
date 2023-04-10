// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:chopper/chopper.dart' as chopper;
import 'orditori.enums.swagger.dart' as enums;
export 'orditori.enums.swagger.dart';

part 'orditori.swagger.chopper.dart';
part 'orditori.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Orditori extends ChopperService {
  static Orditori create({
    ChopperClient? client,
    Authenticator? authenticator,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$Orditori(client);
    }

    final newClient = ChopperClient(
        services: [_$Orditori()],
        converter: $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        authenticator: authenticator,
        baseUrl: baseUrl ?? Uri.parse('http://'));
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
  ///@param adminKey
  Future<chopper.Response<NotebookR>> notebooksPost({
    required String? apiKey,
    required String? adminKey,
  }) {
    generatedMapping.putIfAbsent(NotebookR, () => NotebookR.fromJsonFactory);

    return _notebooksPost(apiKey: apiKey, adminKey: adminKey);
  }

  ///
  ///@param apiKey
  ///@param adminKey
  @Post(
    path: '/notebooks',
    optionalBody: true,
  )
  Future<chopper.Response<NotebookR>> _notebooksPost({
    @Query('apiKey') required String? apiKey,
    @Query('adminKey') required String? adminKey,
  });

  ///
  ///@param apiKey
  Future<chopper.Response<int>> notebookEntriesPost({
    required String? apiKey,
    required NotebookEntryW? body,
  }) {
    return _notebookEntriesPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  @Post(
    path: '/notebookEntries',
    optionalBody: true,
  )
  Future<chopper.Response<int>> _notebookEntriesPost({
    @Query('apiKey') required String? apiKey,
    @Body() required NotebookEntryW? body,
  });

  ///
  ///@param apiKey
  ///@param entryId
  Future<chopper.Response> notebookEntriesEntryIdDelete({
    required String? apiKey,
    required int? entryId,
  }) {
    return _notebookEntriesEntryIdDelete(apiKey: apiKey, entryId: entryId);
  }

  ///
  ///@param apiKey
  ///@param entryId
  @Delete(path: '/notebookEntries/{entryId}')
  Future<chopper.Response> _notebookEntriesEntryIdDelete({
    @Query('apiKey') required String? apiKey,
    @Path('entryId') required int? entryId,
  });

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
  Future<chopper.Response<int>> definitionContentItemsPost({
    required String? apiKey,
    required DefinitionContentItemW? body,
  }) {
    return _definitionContentItemsPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  @Post(
    path: '/definitionContentItems',
    optionalBody: true,
  )
  Future<chopper.Response<int>> _definitionContentItemsPost({
    @Query('apiKey') required String? apiKey,
    @Body() required DefinitionContentItemW? body,
  });

  ///
  ///@param apiKey
  ///@param language
  Future<chopper.Response<DefinitionExerciseR>> exercisesDefinitionRandomGet({
    required String? apiKey,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
        DefinitionExerciseR, () => DefinitionExerciseR.fromJsonFactory);

    return _exercisesDefinitionRandomGet(apiKey: apiKey, language: language);
  }

  ///
  ///@param apiKey
  ///@param language
  @Get(path: '/exercises/definition/random')
  Future<chopper.Response<DefinitionExerciseR>> _exercisesDefinitionRandomGet({
    @Query('apiKey') required String? apiKey,
    @Query('language') String? language,
  });

  ///
  ///@param apiKey
  Future<chopper.Response<SolutionCheckResult>>
      exercisesDefinitionSolutionsPost({
    required String? apiKey,
    required ExerciseSolutionDefinitionExercise? body,
  }) {
    generatedMapping.putIfAbsent(
        SolutionCheckResult, () => SolutionCheckResult.fromJsonFactory);

    return _exercisesDefinitionSolutionsPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  @Post(
    path: '/exercises/definition/solutions',
    optionalBody: true,
  )
  Future<chopper.Response<SolutionCheckResult>>
      _exercisesDefinitionSolutionsPost({
    @Query('apiKey') required String? apiKey,
    @Body() required ExerciseSolutionDefinitionExercise? body,
  });

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
  Future<chopper.Response<SolutionCheckResult>> exercisesExampleSolutionsPost({
    required String? apiKey,
    required ExerciseSolutionDefinitionExampleExercise? body,
  }) {
    generatedMapping.putIfAbsent(
        SolutionCheckResult, () => SolutionCheckResult.fromJsonFactory);

    return _exercisesExampleSolutionsPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  @Post(
    path: '/exercises/example/solutions',
    optionalBody: true,
  )
  Future<chopper.Response<SolutionCheckResult>> _exercisesExampleSolutionsPost({
    @Query('apiKey') required String? apiKey,
    @Body() required ExerciseSolutionDefinitionExampleExercise? body,
  });

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
    required this.apiKey,
    required this.entries,
    required this.formatVersion,
    required this.id,
    required this.revision,
  });

  factory NotebookR.fromJson(Map<String, dynamic> json) =>
      _$NotebookRFromJson(json);

  static const toJsonFactory = _$NotebookRToJson;
  Map<String, dynamic> toJson() => _$NotebookRToJson(this);

  @JsonKey(name: 'apiKey')
  final String apiKey;
  @JsonKey(name: 'entries', defaultValue: <NotebookEntryR>[])
  final List<NotebookEntryR> entries;
  @JsonKey(name: 'formatVersion')
  final int formatVersion;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'revision')
  final int revision;
  static const fromJsonFactory = _$NotebookRFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotebookR &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.entries, entries) ||
                const DeepCollectionEquality()
                    .equals(other.entries, entries)) &&
            (identical(other.formatVersion, formatVersion) ||
                const DeepCollectionEquality()
                    .equals(other.formatVersion, formatVersion)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.revision, revision) ||
                const DeepCollectionEquality()
                    .equals(other.revision, revision)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(entries) ^
      const DeepCollectionEquality().hash(formatVersion) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(revision) ^
      runtimeType.hashCode;
}

extension $NotebookRExtension on NotebookR {
  NotebookR copyWith(
      {String? apiKey,
      List<NotebookEntryR>? entries,
      int? formatVersion,
      int? id,
      int? revision}) {
    return NotebookR(
        apiKey: apiKey ?? this.apiKey,
        entries: entries ?? this.entries,
        formatVersion: formatVersion ?? this.formatVersion,
        id: id ?? this.id,
        revision: revision ?? this.revision);
  }

  NotebookR copyWithWrapped(
      {Wrapped<String>? apiKey,
      Wrapped<List<NotebookEntryR>>? entries,
      Wrapped<int>? formatVersion,
      Wrapped<int>? id,
      Wrapped<int>? revision}) {
    return NotebookR(
        apiKey: (apiKey != null ? apiKey.value : this.apiKey),
        entries: (entries != null ? entries.value : this.entries),
        formatVersion:
            (formatVersion != null ? formatVersion.value : this.formatVersion),
        id: (id != null ? id.value : this.id),
        revision: (revision != null ? revision.value : this.revision));
  }
}

@JsonSerializable(explicitToJson: true)
class NotebookEntryR {
  NotebookEntryR({
    required this.addedDate,
    required this.definitions,
    required this.id,
  });

  factory NotebookEntryR.fromJson(Map<String, dynamic> json) =>
      _$NotebookEntryRFromJson(json);

  static const toJsonFactory = _$NotebookEntryRToJson;
  Map<String, dynamic> toJson() => _$NotebookEntryRToJson(this);

  @JsonKey(name: 'addedDate')
  final String addedDate;
  @JsonKey(name: 'definitions', defaultValue: <DefinitionContentItemR>[])
  final List<DefinitionContentItemR> definitions;
  @JsonKey(name: 'id')
  final int id;
  static const fromJsonFactory = _$NotebookEntryRFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotebookEntryR &&
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
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(addedDate) ^
      const DeepCollectionEquality().hash(definitions) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $NotebookEntryRExtension on NotebookEntryR {
  NotebookEntryR copyWith(
      {String? addedDate, List<DefinitionContentItemR>? definitions, int? id}) {
    return NotebookEntryR(
        addedDate: addedDate ?? this.addedDate,
        definitions: definitions ?? this.definitions,
        id: id ?? this.id);
  }

  NotebookEntryR copyWithWrapped(
      {Wrapped<String>? addedDate,
      Wrapped<List<DefinitionContentItemR>>? definitions,
      Wrapped<int>? id}) {
    return NotebookEntryR(
        addedDate: (addedDate != null ? addedDate.value : this.addedDate),
        definitions:
            (definitions != null ? definitions.value : this.definitions),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionContentItemR {
  DefinitionContentItemR({
    required this.definition,
    required this.definitionId,
    required this.definitionSource,
    required this.examples,
    required this.id,
    required this.language,
    this.partOfSpeech,
    required this.sourceLink,
    required this.word,
  });

  factory DefinitionContentItemR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionContentItemRFromJson(json);

  static const toJsonFactory = _$DefinitionContentItemRToJson;
  Map<String, dynamic> toJson() => _$DefinitionContentItemRToJson(this);

  @JsonKey(name: 'definition')
  final String definition;
  @JsonKey(name: 'definitionId')
  final int definitionId;
  @JsonKey(name: 'definitionSource')
  final int definitionSource;
  @JsonKey(name: 'examples', defaultValue: <DefinitionExample>[])
  final List<DefinitionExample> examples;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'language')
  final Language language;
  @JsonKey(
    name: 'partOfSpeech',
    toJson: partOfSpeechToJson,
    fromJson: partOfSpeechFromJson,
  )
  final enums.PartOfSpeech? partOfSpeech;
  @JsonKey(name: 'sourceLink')
  final String sourceLink;
  @JsonKey(name: 'word')
  final String word;
  static const fromJsonFactory = _$DefinitionContentItemRFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionContentItemR &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.definitionId, definitionId) ||
                const DeepCollectionEquality()
                    .equals(other.definitionId, definitionId)) &&
            (identical(other.definitionSource, definitionSource) ||
                const DeepCollectionEquality()
                    .equals(other.definitionSource, definitionSource)) &&
            (identical(other.examples, examples) ||
                const DeepCollectionEquality()
                    .equals(other.examples, examples)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.partOfSpeech, partOfSpeech) ||
                const DeepCollectionEquality()
                    .equals(other.partOfSpeech, partOfSpeech)) &&
            (identical(other.sourceLink, sourceLink) ||
                const DeepCollectionEquality()
                    .equals(other.sourceLink, sourceLink)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(definitionId) ^
      const DeepCollectionEquality().hash(definitionSource) ^
      const DeepCollectionEquality().hash(examples) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(partOfSpeech) ^
      const DeepCollectionEquality().hash(sourceLink) ^
      const DeepCollectionEquality().hash(word) ^
      runtimeType.hashCode;
}

extension $DefinitionContentItemRExtension on DefinitionContentItemR {
  DefinitionContentItemR copyWith(
      {String? definition,
      int? definitionId,
      int? definitionSource,
      List<DefinitionExample>? examples,
      int? id,
      Language? language,
      enums.PartOfSpeech? partOfSpeech,
      String? sourceLink,
      String? word}) {
    return DefinitionContentItemR(
        definition: definition ?? this.definition,
        definitionId: definitionId ?? this.definitionId,
        definitionSource: definitionSource ?? this.definitionSource,
        examples: examples ?? this.examples,
        id: id ?? this.id,
        language: language ?? this.language,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
        sourceLink: sourceLink ?? this.sourceLink,
        word: word ?? this.word);
  }

  DefinitionContentItemR copyWithWrapped(
      {Wrapped<String>? definition,
      Wrapped<int>? definitionId,
      Wrapped<int>? definitionSource,
      Wrapped<List<DefinitionExample>>? examples,
      Wrapped<int>? id,
      Wrapped<Language>? language,
      Wrapped<enums.PartOfSpeech?>? partOfSpeech,
      Wrapped<String>? sourceLink,
      Wrapped<String>? word}) {
    return DefinitionContentItemR(
        definition: (definition != null ? definition.value : this.definition),
        definitionId:
            (definitionId != null ? definitionId.value : this.definitionId),
        definitionSource: (definitionSource != null
            ? definitionSource.value
            : this.definitionSource),
        examples: (examples != null ? examples.value : this.examples),
        id: (id != null ? id.value : this.id),
        language: (language != null ? language.value : this.language),
        partOfSpeech:
            (partOfSpeech != null ? partOfSpeech.value : this.partOfSpeech),
        sourceLink: (sourceLink != null ? sourceLink.value : this.sourceLink),
        word: (word != null ? word.value : this.word));
  }
}

@JsonSerializable(explicitToJson: true)
class Language {
  Language({
    required this.code,
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  static const toJsonFactory = _$LanguageToJson;
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$LanguageFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Language &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $LanguageExtension on Language {
  Language copyWith({String? code, String? name}) {
    return Language(code: code ?? this.code, name: name ?? this.name);
  }

  Language copyWithWrapped({Wrapped<String>? code, Wrapped<String>? name}) {
    return Language(
        code: (code != null ? code.value : this.code),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExample {
  DefinitionExample({
    required this.definition,
    required this.id,
    required this.$string,
    this.translation,
  });

  factory DefinitionExample.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExampleFromJson(json);

  static const toJsonFactory = _$DefinitionExampleToJson;
  Map<String, dynamic> toJson() => _$DefinitionExampleToJson(this);

  @JsonKey(name: 'definition')
  final int definition;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'string')
  final String $string;
  @JsonKey(name: 'translation')
  final String? translation;
  static const fromJsonFactory = _$DefinitionExampleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExample &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.$string, $string) ||
                const DeepCollectionEquality()
                    .equals(other.$string, $string)) &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash($string) ^
      const DeepCollectionEquality().hash(translation) ^
      runtimeType.hashCode;
}

extension $DefinitionExampleExtension on DefinitionExample {
  DefinitionExample copyWith(
      {int? definition, int? id, String? $string, String? translation}) {
    return DefinitionExample(
        definition: definition ?? this.definition,
        id: id ?? this.id,
        $string: $string ?? this.$string,
        translation: translation ?? this.translation);
  }

  DefinitionExample copyWithWrapped(
      {Wrapped<int>? definition,
      Wrapped<int>? id,
      Wrapped<String>? $string,
      Wrapped<String?>? translation}) {
    return DefinitionExample(
        definition: (definition != null ? definition.value : this.definition),
        id: (id != null ? id.value : this.id),
        $string: ($string != null ? $string.value : this.$string),
        translation:
            (translation != null ? translation.value : this.translation));
  }
}

@JsonSerializable(explicitToJson: true)
class NotebookEntryW {
  NotebookEntryW({
    required this.addedDate,
    required this.notebook,
  });

  factory NotebookEntryW.fromJson(Map<String, dynamic> json) =>
      _$NotebookEntryWFromJson(json);

  static const toJsonFactory = _$NotebookEntryWToJson;
  Map<String, dynamic> toJson() => _$NotebookEntryWToJson(this);

  @JsonKey(name: 'addedDate')
  final String addedDate;
  @JsonKey(name: 'notebook')
  final int notebook;
  static const fromJsonFactory = _$NotebookEntryWFromJson;

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
  String toString() => jsonEncode(this);

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

  NotebookEntryW copyWithWrapped(
      {Wrapped<String>? addedDate, Wrapped<int>? notebook}) {
    return NotebookEntryW(
        addedDate: (addedDate != null ? addedDate.value : this.addedDate),
        notebook: (notebook != null ? notebook.value : this.notebook));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionsWithSource {
  DefinitionsWithSource({
    required this.definitionSource,
    required this.definitions,
  });

  factory DefinitionsWithSource.fromJson(Map<String, dynamic> json) =>
      _$DefinitionsWithSourceFromJson(json);

  static const toJsonFactory = _$DefinitionsWithSourceToJson;
  Map<String, dynamic> toJson() => _$DefinitionsWithSourceToJson(this);

  @JsonKey(name: 'definitionSource')
  final DefinitionSource definitionSource;
  @JsonKey(name: 'definitions', defaultValue: <DefinitionR>[])
  final List<DefinitionR> definitions;
  static const fromJsonFactory = _$DefinitionsWithSourceFromJson;

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
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definitionSource) ^
      const DeepCollectionEquality().hash(definitions) ^
      runtimeType.hashCode;
}

extension $DefinitionsWithSourceExtension on DefinitionsWithSource {
  DefinitionsWithSource copyWith(
      {DefinitionSource? definitionSource, List<DefinitionR>? definitions}) {
    return DefinitionsWithSource(
        definitionSource: definitionSource ?? this.definitionSource,
        definitions: definitions ?? this.definitions);
  }

  DefinitionsWithSource copyWithWrapped(
      {Wrapped<DefinitionSource>? definitionSource,
      Wrapped<List<DefinitionR>>? definitions}) {
    return DefinitionsWithSource(
        definitionSource: (definitionSource != null
            ? definitionSource.value
            : this.definitionSource),
        definitions:
            (definitions != null ? definitions.value : this.definitions));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionR {
  DefinitionR({
    required this.definition,
    required this.examples,
    required this.id,
    required this.language,
    this.partOfSpeech,
    required this.sourceLink,
    required this.word,
  });

  factory DefinitionR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionRFromJson(json);

  static const toJsonFactory = _$DefinitionRToJson;
  Map<String, dynamic> toJson() => _$DefinitionRToJson(this);

  @JsonKey(name: 'definition')
  final String definition;
  @JsonKey(name: 'examples', defaultValue: <DefinitionExample>[])
  final List<DefinitionExample> examples;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'language')
  final Language language;
  @JsonKey(
    name: 'partOfSpeech',
    toJson: partOfSpeechToJson,
    fromJson: partOfSpeechFromJson,
  )
  final enums.PartOfSpeech? partOfSpeech;
  @JsonKey(name: 'sourceLink')
  final String sourceLink;
  @JsonKey(name: 'word')
  final String word;
  static const fromJsonFactory = _$DefinitionRFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionR &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.examples, examples) ||
                const DeepCollectionEquality()
                    .equals(other.examples, examples)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.partOfSpeech, partOfSpeech) ||
                const DeepCollectionEquality()
                    .equals(other.partOfSpeech, partOfSpeech)) &&
            (identical(other.sourceLink, sourceLink) ||
                const DeepCollectionEquality()
                    .equals(other.sourceLink, sourceLink)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(examples) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(partOfSpeech) ^
      const DeepCollectionEquality().hash(sourceLink) ^
      const DeepCollectionEquality().hash(word) ^
      runtimeType.hashCode;
}

extension $DefinitionRExtension on DefinitionR {
  DefinitionR copyWith(
      {String? definition,
      List<DefinitionExample>? examples,
      int? id,
      Language? language,
      enums.PartOfSpeech? partOfSpeech,
      String? sourceLink,
      String? word}) {
    return DefinitionR(
        definition: definition ?? this.definition,
        examples: examples ?? this.examples,
        id: id ?? this.id,
        language: language ?? this.language,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
        sourceLink: sourceLink ?? this.sourceLink,
        word: word ?? this.word);
  }

  DefinitionR copyWithWrapped(
      {Wrapped<String>? definition,
      Wrapped<List<DefinitionExample>>? examples,
      Wrapped<int>? id,
      Wrapped<Language>? language,
      Wrapped<enums.PartOfSpeech?>? partOfSpeech,
      Wrapped<String>? sourceLink,
      Wrapped<String>? word}) {
    return DefinitionR(
        definition: (definition != null ? definition.value : this.definition),
        examples: (examples != null ? examples.value : this.examples),
        id: (id != null ? id.value : this.id),
        language: (language != null ? language.value : this.language),
        partOfSpeech:
            (partOfSpeech != null ? partOfSpeech.value : this.partOfSpeech),
        sourceLink: (sourceLink != null ? sourceLink.value : this.sourceLink),
        word: (word != null ? word.value : this.word));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionSource {
  DefinitionSource({
    required this.description,
    required this.extractorRevision,
    required this.id,
    required this.name,
    required this.scrapeUrl,
  });

  factory DefinitionSource.fromJson(Map<String, dynamic> json) =>
      _$DefinitionSourceFromJson(json);

  static const toJsonFactory = _$DefinitionSourceToJson;
  Map<String, dynamic> toJson() => _$DefinitionSourceToJson(this);

  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'extractorRevision')
  final String extractorRevision;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'scrapeUrl')
  final String scrapeUrl;
  static const fromJsonFactory = _$DefinitionSourceFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionSource &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.extractorRevision, extractorRevision) ||
                const DeepCollectionEquality()
                    .equals(other.extractorRevision, extractorRevision)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.scrapeUrl, scrapeUrl) ||
                const DeepCollectionEquality()
                    .equals(other.scrapeUrl, scrapeUrl)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(extractorRevision) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(scrapeUrl) ^
      runtimeType.hashCode;
}

extension $DefinitionSourceExtension on DefinitionSource {
  DefinitionSource copyWith(
      {String? description,
      String? extractorRevision,
      int? id,
      String? name,
      String? scrapeUrl}) {
    return DefinitionSource(
        description: description ?? this.description,
        extractorRevision: extractorRevision ?? this.extractorRevision,
        id: id ?? this.id,
        name: name ?? this.name,
        scrapeUrl: scrapeUrl ?? this.scrapeUrl);
  }

  DefinitionSource copyWithWrapped(
      {Wrapped<String>? description,
      Wrapped<String>? extractorRevision,
      Wrapped<int>? id,
      Wrapped<String>? name,
      Wrapped<String>? scrapeUrl}) {
    return DefinitionSource(
        description:
            (description != null ? description.value : this.description),
        extractorRevision: (extractorRevision != null
            ? extractorRevision.value
            : this.extractorRevision),
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        scrapeUrl: (scrapeUrl != null ? scrapeUrl.value : this.scrapeUrl));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionContentItemW {
  DefinitionContentItemW({
    required this.definition,
    required this.entry,
  });

  factory DefinitionContentItemW.fromJson(Map<String, dynamic> json) =>
      _$DefinitionContentItemWFromJson(json);

  static const toJsonFactory = _$DefinitionContentItemWToJson;
  Map<String, dynamic> toJson() => _$DefinitionContentItemWToJson(this);

  @JsonKey(name: 'definition')
  final int definition;
  @JsonKey(name: 'entry')
  final int entry;
  static const fromJsonFactory = _$DefinitionContentItemWFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionContentItemW &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.entry, entry) ||
                const DeepCollectionEquality().equals(other.entry, entry)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(entry) ^
      runtimeType.hashCode;
}

extension $DefinitionContentItemWExtension on DefinitionContentItemW {
  DefinitionContentItemW copyWith({int? definition, int? entry}) {
    return DefinitionContentItemW(
        definition: definition ?? this.definition, entry: entry ?? this.entry);
  }

  DefinitionContentItemW copyWithWrapped(
      {Wrapped<int>? definition, Wrapped<int>? entry}) {
    return DefinitionContentItemW(
        definition: (definition != null ? definition.value : this.definition),
        entry: (entry != null ? entry.value : this.entry));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExerciseR {
  DefinitionExerciseR({
    required this.definition,
    required this.difficultyScore,
    required this.id,
    required this.language,
    required this.options,
  });

  factory DefinitionExerciseR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExerciseRFromJson(json);

  static const toJsonFactory = _$DefinitionExerciseRToJson;
  Map<String, dynamic> toJson() => _$DefinitionExerciseRToJson(this);

  @JsonKey(name: 'definition')
  final String definition;
  @JsonKey(name: 'difficultyScore')
  final double difficultyScore;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'language')
  final Language language;
  @JsonKey(name: 'options', defaultValue: <String>[])
  final List<String> options;
  static const fromJsonFactory = _$DefinitionExerciseRFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExerciseR &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $DefinitionExerciseRExtension on DefinitionExerciseR {
  DefinitionExerciseR copyWith(
      {String? definition,
      double? difficultyScore,
      int? id,
      Language? language,
      List<String>? options}) {
    return DefinitionExerciseR(
        definition: definition ?? this.definition,
        difficultyScore: difficultyScore ?? this.difficultyScore,
        id: id ?? this.id,
        language: language ?? this.language,
        options: options ?? this.options);
  }

  DefinitionExerciseR copyWithWrapped(
      {Wrapped<String>? definition,
      Wrapped<double>? difficultyScore,
      Wrapped<int>? id,
      Wrapped<Language>? language,
      Wrapped<List<String>>? options}) {
    return DefinitionExerciseR(
        definition: (definition != null ? definition.value : this.definition),
        difficultyScore: (difficultyScore != null
            ? difficultyScore.value
            : this.difficultyScore),
        id: (id != null ? id.value : this.id),
        language: (language != null ? language.value : this.language),
        options: (options != null ? options.value : this.options));
  }
}

@JsonSerializable(explicitToJson: true)
class SolutionCheckResult {
  SolutionCheckResult();

  factory SolutionCheckResult.fromJson(Map<String, dynamic> json) =>
      _$SolutionCheckResultFromJson(json);

  static const toJsonFactory = _$SolutionCheckResultToJson;
  Map<String, dynamic> toJson() => _$SolutionCheckResultToJson(this);

  static const fromJsonFactory = _$SolutionCheckResultFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class FuzzyCompareToken {
  FuzzyCompareToken();

  factory FuzzyCompareToken.fromJson(Map<String, dynamic> json) =>
      _$FuzzyCompareTokenFromJson(json);

  static const toJsonFactory = _$FuzzyCompareTokenToJson;
  Map<String, dynamic> toJson() => _$FuzzyCompareTokenToJson(this);

  static const fromJsonFactory = _$FuzzyCompareTokenFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class FuzzyCompareIssue {
  FuzzyCompareIssue({
    required this.actual,
    required this.expected,
  });

  factory FuzzyCompareIssue.fromJson(Map<String, dynamic> json) =>
      _$FuzzyCompareIssueFromJson(json);

  static const toJsonFactory = _$FuzzyCompareIssueToJson;
  Map<String, dynamic> toJson() => _$FuzzyCompareIssueToJson(this);

  @JsonKey(name: 'actual')
  final String actual;
  @JsonKey(name: 'expected')
  final String expected;
  static const fromJsonFactory = _$FuzzyCompareIssueFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FuzzyCompareIssue &&
            (identical(other.actual, actual) ||
                const DeepCollectionEquality().equals(other.actual, actual)) &&
            (identical(other.expected, expected) ||
                const DeepCollectionEquality()
                    .equals(other.expected, expected)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(actual) ^
      const DeepCollectionEquality().hash(expected) ^
      runtimeType.hashCode;
}

extension $FuzzyCompareIssueExtension on FuzzyCompareIssue {
  FuzzyCompareIssue copyWith({String? actual, String? expected}) {
    return FuzzyCompareIssue(
        actual: actual ?? this.actual, expected: expected ?? this.expected);
  }

  FuzzyCompareIssue copyWithWrapped(
      {Wrapped<String>? actual, Wrapped<String>? expected}) {
    return FuzzyCompareIssue(
        actual: (actual != null ? actual.value : this.actual),
        expected: (expected != null ? expected.value : this.expected));
  }
}

@JsonSerializable(explicitToJson: true)
class ExerciseSolutionDefinitionExercise {
  ExerciseSolutionDefinitionExercise({
    required this.exercise,
    required this.input,
  });

  factory ExerciseSolutionDefinitionExercise.fromJson(
          Map<String, dynamic> json) =>
      _$ExerciseSolutionDefinitionExerciseFromJson(json);

  static const toJsonFactory = _$ExerciseSolutionDefinitionExerciseToJson;
  Map<String, dynamic> toJson() =>
      _$ExerciseSolutionDefinitionExerciseToJson(this);

  @JsonKey(name: 'exercise')
  final int exercise;
  @JsonKey(name: 'input')
  final String input;
  static const fromJsonFactory = _$ExerciseSolutionDefinitionExerciseFromJson;

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
  String toString() => jsonEncode(this);

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

  ExerciseSolutionDefinitionExercise copyWithWrapped(
      {Wrapped<int>? exercise, Wrapped<String>? input}) {
    return ExerciseSolutionDefinitionExercise(
        exercise: (exercise != null ? exercise.value : this.exercise),
        input: (input != null ? input.value : this.input));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExerciseStatsDefinitionExercise {
  DefinitionExerciseStatsDefinitionExercise({
    required this.correct,
    required this.definition,
    required this.difficultyScore,
    required this.id,
    required this.incorrect,
  });

  factory DefinitionExerciseStatsDefinitionExercise.fromJson(
          Map<String, dynamic> json) =>
      _$DefinitionExerciseStatsDefinitionExerciseFromJson(json);

  static const toJsonFactory =
      _$DefinitionExerciseStatsDefinitionExerciseToJson;
  Map<String, dynamic> toJson() =>
      _$DefinitionExerciseStatsDefinitionExerciseToJson(this);

  @JsonKey(name: 'correct')
  final int correct;
  @JsonKey(name: 'definition')
  final Definition definition;
  @JsonKey(name: 'difficultyScore')
  final double difficultyScore;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'incorrect')
  final int incorrect;
  static const fromJsonFactory =
      _$DefinitionExerciseStatsDefinitionExerciseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExerciseStatsDefinitionExercise &&
            (identical(other.correct, correct) ||
                const DeepCollectionEquality()
                    .equals(other.correct, correct)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.incorrect, incorrect) ||
                const DeepCollectionEquality()
                    .equals(other.incorrect, incorrect)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(correct) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(incorrect) ^
      runtimeType.hashCode;
}

extension $DefinitionExerciseStatsDefinitionExerciseExtension
    on DefinitionExerciseStatsDefinitionExercise {
  DefinitionExerciseStatsDefinitionExercise copyWith(
      {int? correct,
      Definition? definition,
      double? difficultyScore,
      int? id,
      int? incorrect}) {
    return DefinitionExerciseStatsDefinitionExercise(
        correct: correct ?? this.correct,
        definition: definition ?? this.definition,
        difficultyScore: difficultyScore ?? this.difficultyScore,
        id: id ?? this.id,
        incorrect: incorrect ?? this.incorrect);
  }

  DefinitionExerciseStatsDefinitionExercise copyWithWrapped(
      {Wrapped<int>? correct,
      Wrapped<Definition>? definition,
      Wrapped<double>? difficultyScore,
      Wrapped<int>? id,
      Wrapped<int>? incorrect}) {
    return DefinitionExerciseStatsDefinitionExercise(
        correct: (correct != null ? correct.value : this.correct),
        definition: (definition != null ? definition.value : this.definition),
        difficultyScore: (difficultyScore != null
            ? difficultyScore.value
            : this.difficultyScore),
        id: (id != null ? id.value : this.id),
        incorrect: (incorrect != null ? incorrect.value : this.incorrect));
  }
}

@JsonSerializable(explicitToJson: true)
class Definition {
  Definition({
    required this.definition,
    required this.id,
    required this.language,
    required this.page,
    this.partOfSpeech,
    required this.sourceLink,
    required this.word,
  });

  factory Definition.fromJson(Map<String, dynamic> json) =>
      _$DefinitionFromJson(json);

  static const toJsonFactory = _$DefinitionToJson;
  Map<String, dynamic> toJson() => _$DefinitionToJson(this);

  @JsonKey(name: 'definition')
  final String definition;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'language')
  final String language;
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(
    name: 'partOfSpeech',
    toJson: partOfSpeechToJson,
    fromJson: partOfSpeechFromJson,
  )
  final enums.PartOfSpeech? partOfSpeech;
  @JsonKey(name: 'sourceLink')
  final String sourceLink;
  @JsonKey(name: 'word')
  final String word;
  static const fromJsonFactory = _$DefinitionFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Definition &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.partOfSpeech, partOfSpeech) ||
                const DeepCollectionEquality()
                    .equals(other.partOfSpeech, partOfSpeech)) &&
            (identical(other.sourceLink, sourceLink) ||
                const DeepCollectionEquality()
                    .equals(other.sourceLink, sourceLink)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(partOfSpeech) ^
      const DeepCollectionEquality().hash(sourceLink) ^
      const DeepCollectionEquality().hash(word) ^
      runtimeType.hashCode;
}

extension $DefinitionExtension on Definition {
  Definition copyWith(
      {String? definition,
      int? id,
      String? language,
      int? page,
      enums.PartOfSpeech? partOfSpeech,
      String? sourceLink,
      String? word}) {
    return Definition(
        definition: definition ?? this.definition,
        id: id ?? this.id,
        language: language ?? this.language,
        page: page ?? this.page,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
        sourceLink: sourceLink ?? this.sourceLink,
        word: word ?? this.word);
  }

  Definition copyWithWrapped(
      {Wrapped<String>? definition,
      Wrapped<int>? id,
      Wrapped<String>? language,
      Wrapped<int>? page,
      Wrapped<enums.PartOfSpeech?>? partOfSpeech,
      Wrapped<String>? sourceLink,
      Wrapped<String>? word}) {
    return Definition(
        definition: (definition != null ? definition.value : this.definition),
        id: (id != null ? id.value : this.id),
        language: (language != null ? language.value : this.language),
        page: (page != null ? page.value : this.page),
        partOfSpeech:
            (partOfSpeech != null ? partOfSpeech.value : this.partOfSpeech),
        sourceLink: (sourceLink != null ? sourceLink.value : this.sourceLink),
        word: (word != null ? word.value : this.word));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExampleExerciseR {
  DefinitionExampleExerciseR({
    required this.definition,
    required this.difficultyScore,
    required this.example,
    required this.id,
    required this.language,
  });

  factory DefinitionExampleExerciseR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExampleExerciseRFromJson(json);

  static const toJsonFactory = _$DefinitionExampleExerciseRToJson;
  Map<String, dynamic> toJson() => _$DefinitionExampleExerciseRToJson(this);

  @JsonKey(name: 'definition')
  final String definition;
  @JsonKey(name: 'difficultyScore')
  final double difficultyScore;
  @JsonKey(name: 'example', defaultValue: <StringOrGap>[])
  final List<StringOrGap> example;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'language')
  final Language language;
  static const fromJsonFactory = _$DefinitionExampleExerciseRFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExampleExerciseR &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)) &&
            (identical(other.example, example) ||
                const DeepCollectionEquality()
                    .equals(other.example, example)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      const DeepCollectionEquality().hash(example) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(language) ^
      runtimeType.hashCode;
}

extension $DefinitionExampleExerciseRExtension on DefinitionExampleExerciseR {
  DefinitionExampleExerciseR copyWith(
      {String? definition,
      double? difficultyScore,
      List<StringOrGap>? example,
      int? id,
      Language? language}) {
    return DefinitionExampleExerciseR(
        definition: definition ?? this.definition,
        difficultyScore: difficultyScore ?? this.difficultyScore,
        example: example ?? this.example,
        id: id ?? this.id,
        language: language ?? this.language);
  }

  DefinitionExampleExerciseR copyWithWrapped(
      {Wrapped<String>? definition,
      Wrapped<double>? difficultyScore,
      Wrapped<List<StringOrGap>>? example,
      Wrapped<int>? id,
      Wrapped<Language>? language}) {
    return DefinitionExampleExerciseR(
        definition: (definition != null ? definition.value : this.definition),
        difficultyScore: (difficultyScore != null
            ? difficultyScore.value
            : this.difficultyScore),
        example: (example != null ? example.value : this.example),
        id: (id != null ? id.value : this.id),
        language: (language != null ? language.value : this.language));
  }
}

@JsonSerializable(explicitToJson: true)
class StringOrGap {
  StringOrGap();

  factory StringOrGap.fromJson(Map<String, dynamic> json) =>
      _$StringOrGapFromJson(json);

  static const toJsonFactory = _$StringOrGapToJson;
  Map<String, dynamic> toJson() => _$StringOrGapToJson(this);

  static const fromJsonFactory = _$StringOrGapFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class ExerciseSolutionDefinitionExampleExercise {
  ExerciseSolutionDefinitionExampleExercise({
    required this.exercise,
    required this.input,
  });

  factory ExerciseSolutionDefinitionExampleExercise.fromJson(
          Map<String, dynamic> json) =>
      _$ExerciseSolutionDefinitionExampleExerciseFromJson(json);

  static const toJsonFactory =
      _$ExerciseSolutionDefinitionExampleExerciseToJson;
  Map<String, dynamic> toJson() =>
      _$ExerciseSolutionDefinitionExampleExerciseToJson(this);

  @JsonKey(name: 'exercise')
  final int exercise;
  @JsonKey(name: 'input')
  final String input;
  static const fromJsonFactory =
      _$ExerciseSolutionDefinitionExampleExerciseFromJson;

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
  String toString() => jsonEncode(this);

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

  ExerciseSolutionDefinitionExampleExercise copyWithWrapped(
      {Wrapped<int>? exercise, Wrapped<String>? input}) {
    return ExerciseSolutionDefinitionExampleExercise(
        exercise: (exercise != null ? exercise.value : this.exercise),
        input: (input != null ? input.value : this.input));
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExerciseStatsDefinitionExampleExercise {
  DefinitionExerciseStatsDefinitionExampleExercise({
    required this.correct,
    required this.definition,
    required this.difficultyScore,
    required this.id,
    required this.incorrect,
  });

  factory DefinitionExerciseStatsDefinitionExampleExercise.fromJson(
          Map<String, dynamic> json) =>
      _$DefinitionExerciseStatsDefinitionExampleExerciseFromJson(json);

  static const toJsonFactory =
      _$DefinitionExerciseStatsDefinitionExampleExerciseToJson;
  Map<String, dynamic> toJson() =>
      _$DefinitionExerciseStatsDefinitionExampleExerciseToJson(this);

  @JsonKey(name: 'correct')
  final int correct;
  @JsonKey(name: 'definition')
  final Definition definition;
  @JsonKey(name: 'difficultyScore')
  final double difficultyScore;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'incorrect')
  final int incorrect;
  static const fromJsonFactory =
      _$DefinitionExerciseStatsDefinitionExampleExerciseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExerciseStatsDefinitionExampleExercise &&
            (identical(other.correct, correct) ||
                const DeepCollectionEquality()
                    .equals(other.correct, correct)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.incorrect, incorrect) ||
                const DeepCollectionEquality()
                    .equals(other.incorrect, incorrect)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(correct) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(incorrect) ^
      runtimeType.hashCode;
}

extension $DefinitionExerciseStatsDefinitionExampleExerciseExtension
    on DefinitionExerciseStatsDefinitionExampleExercise {
  DefinitionExerciseStatsDefinitionExampleExercise copyWith(
      {int? correct,
      Definition? definition,
      double? difficultyScore,
      int? id,
      int? incorrect}) {
    return DefinitionExerciseStatsDefinitionExampleExercise(
        correct: correct ?? this.correct,
        definition: definition ?? this.definition,
        difficultyScore: difficultyScore ?? this.difficultyScore,
        id: id ?? this.id,
        incorrect: incorrect ?? this.incorrect);
  }

  DefinitionExerciseStatsDefinitionExampleExercise copyWithWrapped(
      {Wrapped<int>? correct,
      Wrapped<Definition>? definition,
      Wrapped<double>? difficultyScore,
      Wrapped<int>? id,
      Wrapped<int>? incorrect}) {
    return DefinitionExerciseStatsDefinitionExampleExercise(
        correct: (correct != null ? correct.value : this.correct),
        definition: (definition != null ? definition.value : this.definition),
        difficultyScore: (difficultyScore != null
            ? difficultyScore.value
            : this.difficultyScore),
        id: (id != null ? id.value : this.id),
        incorrect: (incorrect != null ? incorrect.value : this.incorrect));
  }
}

@JsonSerializable(explicitToJson: true)
class UserStatisticsR {
  UserStatisticsR({
    required this.apiKey,
    required this.languages,
  });

  factory UserStatisticsR.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticsRFromJson(json);

  static const toJsonFactory = _$UserStatisticsRToJson;
  Map<String, dynamic> toJson() => _$UserStatisticsRToJson(this);

  @JsonKey(name: 'apiKey')
  final String apiKey;
  @JsonKey(name: 'languages', defaultValue: <Language>[])
  final List<Language> languages;
  static const fromJsonFactory = _$UserStatisticsRFromJson;

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
  String toString() => jsonEncode(this);

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

  UserStatisticsR copyWithWrapped(
      {Wrapped<String>? apiKey, Wrapped<List<Language>>? languages}) {
    return UserStatisticsR(
        apiKey: (apiKey != null ? apiKey.value : this.apiKey),
        languages: (languages != null ? languages.value : this.languages));
  }
}

String? partOfSpeechToJson(enums.PartOfSpeech? partOfSpeech) {
  return partOfSpeech?.value;
}

enums.PartOfSpeech partOfSpeechFromJson(
  Object? partOfSpeech, [
  enums.PartOfSpeech? defaultValue,
]) {
  return enums.PartOfSpeech.values
          .firstWhereOrNull((e) => e.value == partOfSpeech) ??
      defaultValue ??
      enums.PartOfSpeech.swaggerGeneratedUnknown;
}

List<String> partOfSpeechListToJson(List<enums.PartOfSpeech>? partOfSpeech) {
  if (partOfSpeech == null) {
    return [];
  }

  return partOfSpeech.map((e) => e.value!).toList();
}

List<enums.PartOfSpeech> partOfSpeechListFromJson(
  List? partOfSpeech, [
  List<enums.PartOfSpeech>? defaultValue,
]) {
  if (partOfSpeech == null) {
    return defaultValue ?? [];
  }

  return partOfSpeech.map((e) => partOfSpeechFromJson(e.toString())).toList();
}

List<enums.PartOfSpeech>? partOfSpeechNullableListFromJson(
  List? partOfSpeech, [
  List<enums.PartOfSpeech>? defaultValue,
]) {
  if (partOfSpeech == null) {
    return defaultValue;
  }

  return partOfSpeech.map((e) => partOfSpeechFromJson(e.toString())).toList();
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

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
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
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = await super.convertResponse(response);
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

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}

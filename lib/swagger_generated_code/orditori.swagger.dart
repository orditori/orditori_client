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
  ///@param body
  Future<chopper.Response<int>> notebookEntriesPost(
      {required String? apiKey, required NotebookEntryW? body}) {
    generatedMapping.putIfAbsent(
        NotebookEntryW, () => NotebookEntryW.fromJsonFactory);

    return _notebookEntriesPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  ///@param body
  @Post(path: '/notebookEntries')
  Future<chopper.Response<int>> _notebookEntriesPost(
      {@Query('apiKey') required String? apiKey,
      @Body() required NotebookEntryW? body});

  ///
  ///@param apiKey
  ///@param entryId
  Future<chopper.Response<List<Object>>> notebookEntriesEntryIdDelete(
      {required String? apiKey, required int? entryId}) {
    return _notebookEntriesEntryIdDelete(apiKey: apiKey, entryId: entryId);
  }

  ///
  ///@param apiKey
  ///@param entryId
  @Delete(path: '/notebookEntries/{entryId}')
  Future<chopper.Response<List<Object>>> _notebookEntriesEntryIdDelete(
      {@Query('apiKey') required String? apiKey,
      @Path('entryId') required int? entryId});

  ///
  ///@param query
  Future<chopper.Response<List<Definition>>> definitionsGet(
      {required String? query}) {
    generatedMapping.putIfAbsent(Definition, () => Definition.fromJsonFactory);

    return _definitionsGet(query: query);
  }

  ///
  ///@param query
  @Get(path: '/definitions')
  Future<chopper.Response<List<Definition>>> _definitionsGet(
      {@Query('query') required String? query});

  ///
  ///@param apiKey
  ///@param body
  Future<chopper.Response<int>> definitionExamplesPost(
      {required String? apiKey, required DefinitionExampleW? body}) {
    generatedMapping.putIfAbsent(
        DefinitionExampleW, () => DefinitionExampleW.fromJsonFactory);

    return _definitionExamplesPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  ///@param body
  @Post(path: '/definitionExamples')
  Future<chopper.Response<int>> _definitionExamplesPost(
      {@Query('apiKey') required String? apiKey,
      @Body() required DefinitionExampleW? body});

  ///
  ///@param apiKey
  ///@param body
  Future<chopper.Response<int>> definitionContentItemsPost(
      {required String? apiKey, required DefinitionContentItemW? body}) {
    generatedMapping.putIfAbsent(
        DefinitionContentItemW, () => DefinitionContentItemW.fromJsonFactory);

    return _definitionContentItemsPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  ///@param body
  @Post(path: '/definitionContentItems')
  Future<chopper.Response<int>> _definitionContentItemsPost(
      {@Query('apiKey') required String? apiKey,
      @Body() required DefinitionContentItemW? body});

  ///
  ///@param apiKey
  Future<chopper.Response<DefinitionExerciseR>> exercisesDefinitionRandomGet(
      {required String? apiKey}) {
    generatedMapping.putIfAbsent(
        DefinitionExerciseR, () => DefinitionExerciseR.fromJsonFactory);

    return _exercisesDefinitionRandomGet(apiKey: apiKey);
  }

  ///
  ///@param apiKey
  @Get(path: '/exercises/definition/random')
  Future<chopper.Response<DefinitionExerciseR>> _exercisesDefinitionRandomGet(
      {@Query('apiKey') required String? apiKey});

  ///
  ///@param apiKey
  ///@param body
  Future<chopper.Response<SolutionCheckResult>>
      exercisesDefinitionSolutionsPost(
          {required String? apiKey, required ExerciseSolution? body}) {
    generatedMapping.putIfAbsent(
        ExerciseSolution, () => ExerciseSolution.fromJsonFactory);
    generatedMapping.putIfAbsent(
        SolutionCheckResult, () => SolutionCheckResult.fromJsonFactory);

    return _exercisesDefinitionSolutionsPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  ///@param body
  @Post(path: '/exercises/definition/solutions')
  Future<chopper.Response<SolutionCheckResult>>
      _exercisesDefinitionSolutionsPost(
          {@Query('apiKey') required String? apiKey,
          @Body() required ExerciseSolution? body});

  ///
  ///@param apiKey
  Future<chopper.Response<List<DefinitionExerciseStats>>>
      exercisesDefinitionScoresGet({required String? apiKey}) {
    generatedMapping.putIfAbsent(
        DefinitionExerciseStats, () => DefinitionExerciseStats.fromJsonFactory);

    return _exercisesDefinitionScoresGet(apiKey: apiKey);
  }

  ///
  ///@param apiKey
  @Get(path: '/exercises/definition/scores')
  Future<chopper.Response<List<DefinitionExerciseStats>>>
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
  ///@param body
  Future<chopper.Response<SolutionCheckResult>> exercisesExampleSolutionsPost(
      {required String? apiKey, required ExerciseSolution? body}) {
    generatedMapping.putIfAbsent(
        ExerciseSolution, () => ExerciseSolution.fromJsonFactory);
    generatedMapping.putIfAbsent(
        SolutionCheckResult, () => SolutionCheckResult.fromJsonFactory);

    return _exercisesExampleSolutionsPost(apiKey: apiKey, body: body);
  }

  ///
  ///@param apiKey
  ///@param body
  @Post(path: '/exercises/example/solutions')
  Future<chopper.Response<SolutionCheckResult>> _exercisesExampleSolutionsPost(
      {@Query('apiKey') required String? apiKey,
      @Body() required ExerciseSolution? body});

  ///
  ///@param apiKey
  Future<chopper.Response<List<DefinitionExerciseStats>>>
      exercisesExampleScoresGet({required String? apiKey}) {
    generatedMapping.putIfAbsent(
        DefinitionExerciseStats, () => DefinitionExerciseStats.fromJsonFactory);

    return _exercisesExampleScoresGet(apiKey: apiKey);
  }

  ///
  ///@param apiKey
  @Get(path: '/exercises/example/scores')
  Future<chopper.Response<List<DefinitionExerciseStats>>>
      _exercisesExampleScoresGet({@Query('apiKey') required String? apiKey});
}

@JsonSerializable(explicitToJson: true)
class NotebookR {
  NotebookR({
    this.id,
    this.apiKey,
    this.revision,
    this.formatVersion,
    this.entries,
  });

  factory NotebookR.fromJson(Map<String, dynamic> json) =>
      _$NotebookRFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'apiKey')
  final String? apiKey;
  @JsonKey(name: 'revision')
  final int? revision;
  @JsonKey(name: 'formatVersion')
  final int? formatVersion;
  @JsonKey(name: 'entries', defaultValue: <NotebookEntryR>[])
  final List<NotebookEntryR>? entries;
  static const fromJsonFactory = _$NotebookRFromJson;
  static const toJsonFactory = _$NotebookRToJson;
  Map<String, dynamic> toJson() => _$NotebookRToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotebookR &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.revision, revision) ||
                const DeepCollectionEquality()
                    .equals(other.revision, revision)) &&
            (identical(other.formatVersion, formatVersion) ||
                const DeepCollectionEquality()
                    .equals(other.formatVersion, formatVersion)) &&
            (identical(other.entries, entries) ||
                const DeepCollectionEquality().equals(other.entries, entries)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(revision) ^
      const DeepCollectionEquality().hash(formatVersion) ^
      const DeepCollectionEquality().hash(entries) ^
      runtimeType.hashCode;
}

extension $NotebookRExtension on NotebookR {
  NotebookR copyWith(
      {int? id,
      String? apiKey,
      int? revision,
      int? formatVersion,
      List<NotebookEntryR>? entries}) {
    return NotebookR(
        id: id ?? this.id,
        apiKey: apiKey ?? this.apiKey,
        revision: revision ?? this.revision,
        formatVersion: formatVersion ?? this.formatVersion,
        entries: entries ?? this.entries);
  }
}

@JsonSerializable(explicitToJson: true)
class Id {
  Id({
    this.untyped,
  });

  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);

  @JsonKey(name: 'untyped')
  final int? untyped;
  static const fromJsonFactory = _$IdFromJson;
  static const toJsonFactory = _$IdToJson;
  Map<String, dynamic> toJson() => _$IdToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Id &&
            (identical(other.untyped, untyped) ||
                const DeepCollectionEquality().equals(other.untyped, untyped)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(untyped) ^ runtimeType.hashCode;
}

extension $IdExtension on Id {
  Id copyWith({int? untyped}) {
    return Id(untyped: untyped ?? this.untyped);
  }
}

@JsonSerializable(explicitToJson: true)
class NotebookEntryR {
  NotebookEntryR({
    this.id,
    this.addedDate,
    this.definitions,
  });

  factory NotebookEntryR.fromJson(Map<String, dynamic> json) =>
      _$NotebookEntryRFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'addedDate')
  final String? addedDate;
  @JsonKey(name: 'definitions', defaultValue: <DefinitionContentItemR>[])
  final List<DefinitionContentItemR>? definitions;
  static const fromJsonFactory = _$NotebookEntryRFromJson;
  static const toJsonFactory = _$NotebookEntryRToJson;
  Map<String, dynamic> toJson() => _$NotebookEntryRToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotebookEntryR &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.addedDate, addedDate) ||
                const DeepCollectionEquality()
                    .equals(other.addedDate, addedDate)) &&
            (identical(other.definitions, definitions) ||
                const DeepCollectionEquality()
                    .equals(other.definitions, definitions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(addedDate) ^
      const DeepCollectionEquality().hash(definitions) ^
      runtimeType.hashCode;
}

extension $NotebookEntryRExtension on NotebookEntryR {
  NotebookEntryR copyWith(
      {int? id, String? addedDate, List<DefinitionContentItemR>? definitions}) {
    return NotebookEntryR(
        id: id ?? this.id,
        addedDate: addedDate ?? this.addedDate,
        definitions: definitions ?? this.definitions);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionContentItemR {
  DefinitionContentItemR({
    this.id,
    this.word,
    this.language,
    this.definition,
    this.examples,
  });

  factory DefinitionContentItemR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionContentItemRFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'word')
  final String? word;
  @JsonKey(name: 'language')
  final Language? language;
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
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.examples, examples) ||
                const DeepCollectionEquality()
                    .equals(other.examples, examples)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(word) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(examples) ^
      runtimeType.hashCode;
}

extension $DefinitionContentItemRExtension on DefinitionContentItemR {
  DefinitionContentItemR copyWith(
      {int? id,
      String? word,
      Language? language,
      String? definition,
      List<DefinitionExample>? examples}) {
    return DefinitionContentItemR(
        id: id ?? this.id,
        word: word ?? this.word,
        language: language ?? this.language,
        definition: definition ?? this.definition,
        examples: examples ?? this.examples);
  }
}

@JsonSerializable(explicitToJson: true)
class Language {
  Language({
    this.code,
    this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  static const fromJsonFactory = _$LanguageFromJson;
  static const toJsonFactory = _$LanguageToJson;
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

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
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $LanguageExtension on Language {
  Language copyWith({String? code, String? name}) {
    return Language(code: code ?? this.code, name: name ?? this.name);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExample {
  DefinitionExample({
    this.id,
    this.definition,
    this.$String,
    this.translation,
  });

  factory DefinitionExample.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExampleFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'definition')
  final int? definition;
  @JsonKey(name: 'string')
  final String? $String;
  @JsonKey(name: 'translation')
  final String? translation;
  static const fromJsonFactory = _$DefinitionExampleFromJson;
  static const toJsonFactory = _$DefinitionExampleToJson;
  Map<String, dynamic> toJson() => _$DefinitionExampleToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExample &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.$String, $String) ||
                const DeepCollectionEquality()
                    .equals(other.$String, $String)) &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash($String) ^
      const DeepCollectionEquality().hash(translation) ^
      runtimeType.hashCode;
}

extension $DefinitionExampleExtension on DefinitionExample {
  DefinitionExample copyWith(
      {int? id, int? definition, String? $String, String? translation}) {
    return DefinitionExample(
        id: id ?? this.id,
        definition: definition ?? this.definition,
        $String: $String ?? this.$String,
        translation: translation ?? this.translation);
  }
}

@JsonSerializable(explicitToJson: true)
class NotebookEntryW {
  NotebookEntryW({
    this.notebook,
    this.addedDate,
  });

  factory NotebookEntryW.fromJson(Map<String, dynamic> json) =>
      _$NotebookEntryWFromJson(json);

  @JsonKey(name: 'notebook')
  final int? notebook;
  @JsonKey(name: 'addedDate')
  final String? addedDate;
  static const fromJsonFactory = _$NotebookEntryWFromJson;
  static const toJsonFactory = _$NotebookEntryWToJson;
  Map<String, dynamic> toJson() => _$NotebookEntryWToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotebookEntryW &&
            (identical(other.notebook, notebook) ||
                const DeepCollectionEquality()
                    .equals(other.notebook, notebook)) &&
            (identical(other.addedDate, addedDate) ||
                const DeepCollectionEquality()
                    .equals(other.addedDate, addedDate)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(notebook) ^
      const DeepCollectionEquality().hash(addedDate) ^
      runtimeType.hashCode;
}

extension $NotebookEntryWExtension on NotebookEntryW {
  NotebookEntryW copyWith({int? notebook, String? addedDate}) {
    return NotebookEntryW(
        notebook: notebook ?? this.notebook,
        addedDate: addedDate ?? this.addedDate);
  }
}

@JsonSerializable(explicitToJson: true)
class Definition {
  Definition({
    this.word,
    this.language,
    this.definition,
    this.examples,
  });

  factory Definition.fromJson(Map<String, dynamic> json) =>
      _$DefinitionFromJson(json);

  @JsonKey(name: 'word')
  final String? word;
  @JsonKey(name: 'language')
  final Language? language;
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
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.examples, examples) ||
                const DeepCollectionEquality()
                    .equals(other.examples, examples)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(word) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(examples) ^
      runtimeType.hashCode;
}

extension $DefinitionExtension on Definition {
  Definition copyWith(
      {String? word,
      Language? language,
      String? definition,
      List<Example>? examples}) {
    return Definition(
        word: word ?? this.word,
        language: language ?? this.language,
        definition: definition ?? this.definition,
        examples: examples ?? this.examples);
  }
}

@JsonSerializable(explicitToJson: true)
class Example {
  Example({
    this.$String,
    this.translation,
  });

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  @JsonKey(name: 'string')
  final String? $String;
  @JsonKey(name: 'translation')
  final String? translation;
  static const fromJsonFactory = _$ExampleFromJson;
  static const toJsonFactory = _$ExampleToJson;
  Map<String, dynamic> toJson() => _$ExampleToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Example &&
            (identical(other.$String, $String) ||
                const DeepCollectionEquality()
                    .equals(other.$String, $String)) &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($String) ^
      const DeepCollectionEquality().hash(translation) ^
      runtimeType.hashCode;
}

extension $ExampleExtension on Example {
  Example copyWith({String? $String, String? translation}) {
    return Example(
        $String: $String ?? this.$String,
        translation: translation ?? this.translation);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExampleW {
  DefinitionExampleW({
    this.definition,
    this.$String,
    this.translation,
  });

  factory DefinitionExampleW.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExampleWFromJson(json);

  @JsonKey(name: 'definition')
  final int? definition;
  @JsonKey(name: 'string')
  final String? $String;
  @JsonKey(name: 'translation')
  final String? translation;
  static const fromJsonFactory = _$DefinitionExampleWFromJson;
  static const toJsonFactory = _$DefinitionExampleWToJson;
  Map<String, dynamic> toJson() => _$DefinitionExampleWToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExampleW &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.$String, $String) ||
                const DeepCollectionEquality()
                    .equals(other.$String, $String)) &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash($String) ^
      const DeepCollectionEquality().hash(translation) ^
      runtimeType.hashCode;
}

extension $DefinitionExampleWExtension on DefinitionExampleW {
  DefinitionExampleW copyWith(
      {int? definition, String? $String, String? translation}) {
    return DefinitionExampleW(
        definition: definition ?? this.definition,
        $String: $String ?? this.$String,
        translation: translation ?? this.translation);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionContentItemW {
  DefinitionContentItemW({
    this.entry,
    this.word,
    this.language,
    this.definition,
  });

  factory DefinitionContentItemW.fromJson(Map<String, dynamic> json) =>
      _$DefinitionContentItemWFromJson(json);

  @JsonKey(name: 'entry')
  final int? entry;
  @JsonKey(name: 'word')
  final String? word;
  @JsonKey(name: 'language')
  final Language? language;
  @JsonKey(name: 'definition')
  final String? definition;
  static const fromJsonFactory = _$DefinitionContentItemWFromJson;
  static const toJsonFactory = _$DefinitionContentItemWToJson;
  Map<String, dynamic> toJson() => _$DefinitionContentItemWToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionContentItemW &&
            (identical(other.entry, entry) ||
                const DeepCollectionEquality().equals(other.entry, entry)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(entry) ^
      const DeepCollectionEquality().hash(word) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(definition) ^
      runtimeType.hashCode;
}

extension $DefinitionContentItemWExtension on DefinitionContentItemW {
  DefinitionContentItemW copyWith(
      {int? entry, String? word, Language? language, String? definition}) {
    return DefinitionContentItemW(
        entry: entry ?? this.entry,
        word: word ?? this.word,
        language: language ?? this.language,
        definition: definition ?? this.definition);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExerciseR {
  DefinitionExerciseR({
    this.id,
    this.language,
    this.definition,
    this.difficultyScore,
  });

  factory DefinitionExerciseR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExerciseRFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'language')
  final Language? language;
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
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      runtimeType.hashCode;
}

extension $DefinitionExerciseRExtension on DefinitionExerciseR {
  DefinitionExerciseR copyWith(
      {int? id,
      Language? language,
      String? definition,
      double? difficultyScore}) {
    return DefinitionExerciseR(
        id: id ?? this.id,
        language: language ?? this.language,
        definition: definition ?? this.definition,
        difficultyScore: difficultyScore ?? this.difficultyScore);
  }
}

@JsonSerializable(explicitToJson: true)
class SolutionCheckResult {
  SolutionCheckResult({
    this.incorrect,
    this.correct,
  });

  factory SolutionCheckResult.fromJson(Map<String, dynamic> json) =>
      _$SolutionCheckResultFromJson(json);

  @JsonKey(name: 'Incorrect')
  final String? incorrect;
  @JsonKey(name: 'Correct', defaultValue: <FuzzyCompareToken>[])
  final List<FuzzyCompareToken>? correct;
  static const fromJsonFactory = _$SolutionCheckResultFromJson;
  static const toJsonFactory = _$SolutionCheckResultToJson;
  Map<String, dynamic> toJson() => _$SolutionCheckResultToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SolutionCheckResult &&
            (identical(other.incorrect, incorrect) ||
                const DeepCollectionEquality()
                    .equals(other.incorrect, incorrect)) &&
            (identical(other.correct, correct) ||
                const DeepCollectionEquality().equals(other.correct, correct)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(incorrect) ^
      const DeepCollectionEquality().hash(correct) ^
      runtimeType.hashCode;
}

extension $SolutionCheckResultExtension on SolutionCheckResult {
  SolutionCheckResult copyWith(
      {String? incorrect, List<FuzzyCompareToken>? correct}) {
    return SolutionCheckResult(
        incorrect: incorrect ?? this.incorrect,
        correct: correct ?? this.correct);
  }
}

@JsonSerializable(explicitToJson: true)
class FuzzyCompareToken {
  FuzzyCompareToken({
    this.character,
    this.issue,
  });

  factory FuzzyCompareToken.fromJson(Map<String, dynamic> json) =>
      _$FuzzyCompareTokenFromJson(json);

  @JsonKey(name: 'Character')
  final String? character;
  @JsonKey(name: 'Issue')
  final FuzzyCompareIssue? issue;
  static const fromJsonFactory = _$FuzzyCompareTokenFromJson;
  static const toJsonFactory = _$FuzzyCompareTokenToJson;
  Map<String, dynamic> toJson() => _$FuzzyCompareTokenToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FuzzyCompareToken &&
            (identical(other.character, character) ||
                const DeepCollectionEquality()
                    .equals(other.character, character)) &&
            (identical(other.issue, issue) ||
                const DeepCollectionEquality().equals(other.issue, issue)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(character) ^
      const DeepCollectionEquality().hash(issue) ^
      runtimeType.hashCode;
}

extension $FuzzyCompareTokenExtension on FuzzyCompareToken {
  FuzzyCompareToken copyWith({String? character, FuzzyCompareIssue? issue}) {
    return FuzzyCompareToken(
        character: character ?? this.character, issue: issue ?? this.issue);
  }
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
class ExerciseSolution {
  ExerciseSolution({
    this.exercise,
    this.input,
  });

  factory ExerciseSolution.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSolutionFromJson(json);

  @JsonKey(name: 'exercise')
  final int? exercise;
  @JsonKey(name: 'input')
  final String? input;
  static const fromJsonFactory = _$ExerciseSolutionFromJson;
  static const toJsonFactory = _$ExerciseSolutionToJson;
  Map<String, dynamic> toJson() => _$ExerciseSolutionToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ExerciseSolution &&
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

extension $ExerciseSolutionExtension on ExerciseSolution {
  ExerciseSolution copyWith({int? exercise, String? input}) {
    return ExerciseSolution(
        exercise: exercise ?? this.exercise, input: input ?? this.input);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExerciseStats {
  DefinitionExerciseStats({
    this.id,
    this.definition,
    this.difficultyScore,
    this.correct,
    this.incorrect,
  });

  factory DefinitionExerciseStats.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExerciseStatsFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'definition')
  final DefinitionContentItem? definition;
  @JsonKey(name: 'difficultyScore')
  final double? difficultyScore;
  @JsonKey(name: 'correct')
  final int? correct;
  @JsonKey(name: 'incorrect')
  final int? incorrect;
  static const fromJsonFactory = _$DefinitionExerciseStatsFromJson;
  static const toJsonFactory = _$DefinitionExerciseStatsToJson;
  Map<String, dynamic> toJson() => _$DefinitionExerciseStatsToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionExerciseStats &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.difficultyScore, difficultyScore) ||
                const DeepCollectionEquality()
                    .equals(other.difficultyScore, difficultyScore)) &&
            (identical(other.correct, correct) ||
                const DeepCollectionEquality()
                    .equals(other.correct, correct)) &&
            (identical(other.incorrect, incorrect) ||
                const DeepCollectionEquality()
                    .equals(other.incorrect, incorrect)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      const DeepCollectionEquality().hash(correct) ^
      const DeepCollectionEquality().hash(incorrect) ^
      runtimeType.hashCode;
}

extension $DefinitionExerciseStatsExtension on DefinitionExerciseStats {
  DefinitionExerciseStats copyWith(
      {int? id,
      DefinitionContentItem? definition,
      double? difficultyScore,
      int? correct,
      int? incorrect}) {
    return DefinitionExerciseStats(
        id: id ?? this.id,
        definition: definition ?? this.definition,
        difficultyScore: difficultyScore ?? this.difficultyScore,
        correct: correct ?? this.correct,
        incorrect: incorrect ?? this.incorrect);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionContentItem {
  DefinitionContentItem({
    this.id,
    this.entry,
    this.word,
    this.language,
    this.definition,
  });

  factory DefinitionContentItem.fromJson(Map<String, dynamic> json) =>
      _$DefinitionContentItemFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'entry')
  final int? entry;
  @JsonKey(name: 'word')
  final String? word;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'definition')
  final String? definition;
  static const fromJsonFactory = _$DefinitionContentItemFromJson;
  static const toJsonFactory = _$DefinitionContentItemToJson;
  Map<String, dynamic> toJson() => _$DefinitionContentItemToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefinitionContentItem &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.entry, entry) ||
                const DeepCollectionEquality().equals(other.entry, entry)) &&
            (identical(other.word, word) ||
                const DeepCollectionEquality().equals(other.word, word)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(entry) ^
      const DeepCollectionEquality().hash(word) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(definition) ^
      runtimeType.hashCode;
}

extension $DefinitionContentItemExtension on DefinitionContentItem {
  DefinitionContentItem copyWith(
      {int? id,
      int? entry,
      String? word,
      String? language,
      String? definition}) {
    return DefinitionContentItem(
        id: id ?? this.id,
        entry: entry ?? this.entry,
        word: word ?? this.word,
        language: language ?? this.language,
        definition: definition ?? this.definition);
  }
}

@JsonSerializable(explicitToJson: true)
class DefinitionExampleExerciseR {
  DefinitionExampleExerciseR({
    this.id,
    this.language,
    this.definition,
    this.example,
    this.difficultyScore,
  });

  factory DefinitionExampleExerciseR.fromJson(Map<String, dynamic> json) =>
      _$DefinitionExampleExerciseRFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'language')
  final Language? language;
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
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
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
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(example) ^
      const DeepCollectionEquality().hash(difficultyScore) ^
      runtimeType.hashCode;
}

extension $DefinitionExampleExerciseRExtension on DefinitionExampleExerciseR {
  DefinitionExampleExerciseR copyWith(
      {int? id,
      Language? language,
      String? definition,
      List<StringOrGap>? example,
      double? difficultyScore}) {
    return DefinitionExampleExerciseR(
        id: id ?? this.id,
        language: language ?? this.language,
        definition: definition ?? this.definition,
        example: example ?? this.example,
        difficultyScore: difficultyScore ?? this.difficultyScore);
  }
}

@JsonSerializable(explicitToJson: true)
class StringOrGap {
  StringOrGap({
    this.gap,
    this.$String,
  });

  factory StringOrGap.fromJson(Map<String, dynamic> json) =>
      _$StringOrGapFromJson(json);

  @JsonKey(name: 'Gap')
  final int? gap;
  @JsonKey(name: 'String')
  final String? $String;
  static const fromJsonFactory = _$StringOrGapFromJson;
  static const toJsonFactory = _$StringOrGapToJson;
  Map<String, dynamic> toJson() => _$StringOrGapToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StringOrGap &&
            (identical(other.gap, gap) ||
                const DeepCollectionEquality().equals(other.gap, gap)) &&
            (identical(other.$String, $String) ||
                const DeepCollectionEquality().equals(other.$String, $String)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(gap) ^
      const DeepCollectionEquality().hash($String) ^
      runtimeType.hashCode;
}

extension $StringOrGapExtension on StringOrGap {
  StringOrGap copyWith({int? gap, String? $String}) {
    return StringOrGap(gap: gap ?? this.gap, $String: $String ?? this.$String);
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

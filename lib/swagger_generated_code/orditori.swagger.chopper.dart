// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orditori.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Orditori extends Orditori {
  _$Orditori([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Orditori;

  @override
  Future<Response<NotebookR>> _notebooksGet({required String? apiKey}) {
    final Uri $url = Uri.parse('/notebooks');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<NotebookR, NotebookR>($request);
  }

  @override
  Future<Response<NotebookR>> _notebooksPost({
    required String? apiKey,
    required String? adminKey,
  }) {
    final Uri $url = Uri.parse('/notebooks');
    final Map<String, dynamic> $params = <String, dynamic>{
      'apiKey': apiKey,
      'adminKey': adminKey,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<NotebookR, NotebookR>($request);
  }

  @override
  Future<Response<PaginatedNotebookQueryResponseYear>> _notebooksQueryPost({
    required String? apiKey,
    required NotebookQuery? body,
  }) {
    final Uri $url = Uri.parse('/notebooks/query');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<PaginatedNotebookQueryResponseYear,
        PaginatedNotebookQueryResponseYear>($request);
  }

  @override
  Future<Response<int>> _notebookEntriesPost({
    required String? apiKey,
    required NotebookEntryW? body,
  }) {
    final Uri $url = Uri.parse('/notebookEntries');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<int, int>($request);
  }

  @override
  Future<Response<dynamic>> _notebookEntriesEntryIdDelete({
    required String? apiKey,
    required int? entryId,
  }) {
    final Uri $url = Uri.parse('/notebookEntries/${entryId}');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<DefinitionsWithSource>>> _definitionsGet(
      {required String? query}) {
    final Uri $url = Uri.parse('/definitions');
    final Map<String, dynamic> $params = <String, dynamic>{'query': query};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<DefinitionsWithSource>, DefinitionsWithSource>($request);
  }

  @override
  Future<Response<int>> _definitionContentItemsPost({
    required String? apiKey,
    required DefinitionContentItemW? body,
  }) {
    final Uri $url = Uri.parse('/definitionContentItems');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<int, int>($request);
  }

  @override
  Future<Response<dynamic>>
      _definitionContentItemsDefinitionContentItemIdDelete({
    required String? apiKey,
    required int? definitionContentItemId,
  }) {
    final Uri $url =
        Uri.parse('/definitionContentItems/${definitionContentItemId}');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DefinitionExerciseR>> _exercisesDefinitionRandomGet({
    required String? apiKey,
    String? language,
  }) {
    final Uri $url = Uri.parse('/exercises/definition/random');
    final Map<String, dynamic> $params = <String, dynamic>{
      'apiKey': apiKey,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DefinitionExerciseR, DefinitionExerciseR>($request);
  }

  @override
  Future<Response<SolutionCheckResult>> _exercisesDefinitionSolutionsPost({
    required String? apiKey,
    required ExerciseSolutionDefinitionExercise? body,
  }) {
    final Uri $url = Uri.parse('/exercises/definition/solutions');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SolutionCheckResult, SolutionCheckResult>($request);
  }

  @override
  Future<Response<List<DefinitionExerciseStatsDefinitionExercise>>>
      _exercisesDefinitionScoresGet({required String? apiKey}) {
    final Uri $url = Uri.parse('/exercises/definition/scores');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<DefinitionExerciseStatsDefinitionExercise>,
        DefinitionExerciseStatsDefinitionExercise>($request);
  }

  @override
  Future<Response<DefinitionExampleExerciseR>> _exercisesExampleRandomGet(
      {required String? apiKey}) {
    final Uri $url = Uri.parse('/exercises/example/random');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<DefinitionExampleExerciseR, DefinitionExampleExerciseR>($request);
  }

  @override
  Future<Response<SolutionCheckResult>> _exercisesExampleSolutionsPost({
    required String? apiKey,
    required ExerciseSolutionDefinitionExampleExercise? body,
  }) {
    final Uri $url = Uri.parse('/exercises/example/solutions');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SolutionCheckResult, SolutionCheckResult>($request);
  }

  @override
  Future<Response<List<DefinitionExerciseStatsDefinitionExampleExercise>>>
      _exercisesExampleScoresGet({required String? apiKey}) {
    final Uri $url = Uri.parse('/exercises/example/scores');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<DefinitionExerciseStatsDefinitionExampleExercise>,
        DefinitionExerciseStatsDefinitionExampleExercise>($request);
  }

  @override
  Future<Response<UserStatisticsR>> _userStatisticsGet(
      {required String? apiKey}) {
    final Uri $url = Uri.parse('/userStatistics');
    final Map<String, dynamic> $params = <String, dynamic>{'apiKey': apiKey};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserStatisticsR, UserStatisticsR>($request);
  }
}

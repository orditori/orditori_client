// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orditori.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$Orditori extends Orditori {
  _$Orditori([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Orditori;

  @override
  Future<Response<NotebookR>> _notebooksGet({required String? apiKey}) {
    final $url = '/notebooks';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<NotebookR, NotebookR>($request);
  }

  @override
  Future<Response<int>> _notebookEntriesPost(
      {required String? apiKey, required NotebookEntryW? body}) {
    final $url = '/notebookEntries';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, parameters: $params);
    return client.send<int, int>($request);
  }

  @override
  Future<Response<List<Object>>> _notebookEntriesEntryIdDelete(
      {required String? apiKey, required int? entryId}) {
    final $url = '/notebookEntries/${entryId}';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $request =
        Request('DELETE', $url, client.baseUrl, parameters: $params);
    return client.send<List<Object>, Object>($request);
  }

  @override
  Future<Response<List<Definition>>> _definitionsGet({required String? query}) {
    final $url = '/definitions';
    final $params = <String, dynamic>{'query': query};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Definition>, Definition>($request);
  }

  @override
  Future<Response<int>> _definitionExamplesPost(
      {required String? apiKey, required DefinitionExampleW? body}) {
    final $url = '/definitionExamples';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, parameters: $params);
    return client.send<int, int>($request);
  }

  @override
  Future<Response<int>> _definitionContentItemsPost(
      {required String? apiKey, required DefinitionContentItemW? body}) {
    final $url = '/definitionContentItems';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, parameters: $params);
    return client.send<int, int>($request);
  }

  @override
  Future<Response<DefinitionExerciseR>> _exercisesDefinitionRandomGet(
      {required String? apiKey}) {
    final $url = '/exercises/definition/random';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<DefinitionExerciseR, DefinitionExerciseR>($request);
  }

  @override
  Future<Response<SolutionCheckResult>> _exercisesDefinitionSolutionsPost(
      {required String? apiKey, required ExerciseSolution? body}) {
    final $url = '/exercises/definition/solutions';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, parameters: $params);
    return client.send<SolutionCheckResult, SolutionCheckResult>($request);
  }

  @override
  Future<Response<List<DefinitionExerciseStats>>> _exercisesDefinitionScoresGet(
      {required String? apiKey}) {
    final $url = '/exercises/definition/scores';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client
        .send<List<DefinitionExerciseStats>, DefinitionExerciseStats>($request);
  }

  @override
  Future<Response<DefinitionExampleExerciseR>> _exercisesExampleRandomGet(
      {required String? apiKey}) {
    final $url = '/exercises/example/random';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client
        .send<DefinitionExampleExerciseR, DefinitionExampleExerciseR>($request);
  }

  @override
  Future<Response<SolutionCheckResult>> _exercisesExampleSolutionsPost(
      {required String? apiKey, required ExerciseSolution? body}) {
    final $url = '/exercises/example/solutions';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, parameters: $params);
    return client.send<SolutionCheckResult, SolutionCheckResult>($request);
  }

  @override
  Future<Response<List<DefinitionExerciseStats>>> _exercisesExampleScoresGet(
      {required String? apiKey}) {
    final $url = '/exercises/example/scores';
    final $params = <String, dynamic>{'apiKey': apiKey};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client
        .send<List<DefinitionExerciseStats>, DefinitionExerciseStats>($request);
  }
}

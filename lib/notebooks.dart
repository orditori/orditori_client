import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:flutter_context/flutter_context.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

final notebookContext = createContext<NotebookR>();
final savedDefinitionsContext = createContext<Set<int>>();

Widget withNotebooks(
  String token,
  Widget Function(Trigger refreshNotebook, Widget? child) builder,
) {
  final load = trigger();

  final r = load.asyncHandler((_) {
    return client.notebooksGet(apiKey: token);
  });

  invoke.immediate(load);

  return NotebooksProvider(
    notebookResult: r,
    refreshNotbook: load,
    builder: builder,
  );
}

class NotebooksProvider extends CTWidget {
  final Result<Response<NotebookR>> notebookResult;
  final Trigger refreshNotbook;
  final Widget Function(Trigger refreshNotebook, Widget? child) builder;

  const NotebooksProvider({
    super.key,
    required this.notebookResult,
    required this.refreshNotbook,
    required this.builder,
  });

  @override
  bool shouldUpdate(
    CTNode node,
    NotebooksProvider oldWidget,
    NotebooksProvider newWidget,
  ) {
    return newWidget.notebookResult is Success ||
        newWidget.notebookResult is Failure;
  }

  @override
  Widget build(BuildContext context) {
    final r = notebookResult;

    if (r is Loading || r is Pending) {
      return builder(
        refreshNotbook,
        const Center(child: CircularProgressIndicator()),
      );
    }

    if (r is Failure) {
      return builder(
        refreshNotbook,
        Text(r.failure().exception.toString()),
      );
    }

    final notebook = r.success().value.body!;

    final savedDefinitions = notebook.entries
        .expand((element) => element.definitions)
        .map((e) => e.definitionId)
        .toSet();

    return notebookContext.Provider(
      value: notebook,
      child: savedDefinitionsContext.Provider(
        value: savedDefinitions,
        child: builder(refreshNotbook, null),
      ),
    );
  }
}

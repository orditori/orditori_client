import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:flutter_context/flutter_context.dart';
import 'package:orditori/main.dart';
import 'package:orditori/services.dart';

import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

final notebookContext = createContext<NotebookR>();
final savedDefinitionsContext = createContext<Set<int>>();

Widget withNotebooks({
  required String token,
  required Function(String token) setToken,
  required Widget Function(Trigger refreshNotebook, Widget? child) builder,
}) {
  final load = trigger();

  final r = load.asyncHandler((_) {
    return client.notebooksGet(apiKey: token);
  });

  invoke.immediate(load);

  return NotebooksProvider(
    notebookResult: r,
    refreshNotbook: load,
    builder: builder,
    setToken: setToken,
  );
}

class NotebooksProvider extends CTWidget {
  final Result<Response<NotebookR>> notebookResult;
  final Trigger refreshNotbook;
  final Widget Function(Trigger refreshNotebook, Widget? child) builder;
  final Function(String token) setToken;

  const NotebooksProvider({
    super.key,
    required this.notebookResult,
    required this.refreshNotbook,
    required this.builder,
    required this.setToken,
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

    if (r.success().value.body == null) {
      return builder(
        refreshNotbook,
        CTBuilder((context) {
          invoke.immediate(() async {
            await prefs.clear();
            setToken('');
            // ignore: prefer_const_constructors
            runApp(const Root());
          });

          return const SizedBox();
        }),
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

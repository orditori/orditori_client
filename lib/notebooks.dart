import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/notebooks/notebooks_screen.dart';
import 'package:orditori/services.dart';

import 'swagger_generated_code/orditori.swagger.dart';

class RefreshNotebookToken extends Token<VoidTrigger> {
  const RefreshNotebookToken();
}

Widget withNotebooks({
  required CTNode n,
  required String token,
  required Token<Ref<EdgeInsets>> padding,
  required Widget Function(Widget? child, [NotebooksContext? context]) builder,
}) {
  final load = n.trigger();

  final r = load.asyncHandler(() {
    return client.notebooksQueryPost(
        apiKey: token, body: const NotebookQuery(pageIndex: 1));
  }, invoke: true);

  return CTBuilder(
    (n, context) {
      switch (r) {
        case Loading() || Pending():
          return builder(const Center(child: CircularProgressIndicator()));
        case Failure(exception: final e):
          return builder(Text(e.toString()));
        case Success(value: final v):
          if (v.body == null) {
            return builder(const Center(child: Text('Probably invalid token')));
          }

          final notebookQueryResponse = v.body!;
          final notebookYearGroups = notebookQueryResponse.items;

          final savedDefinitions = notebookYearGroups.items
              .expand((element) => element.months)
              .expand((element) => element.days)
              .expand((element) => element.entries)
              .expand((element) => element.definitions)
              .map((e) => e.definitionId)
              .toSet();

          n.provideValueAsRef(savedDefinitions);

          return builder(null, (
            padding: padding,
            notebookId: n.provideValueAsRef(notebookQueryResponse.notebookId),
            notebookYearGroups: n.provideValueAsRef(notebookYearGroups),
            refreshNotebook: load.provide(const RefreshNotebookToken()),
            savedDefinitions: n.provideValueAsRef(savedDefinitions),
          ));
      }
    },
    context: (),
    dep: [r, token],
    when: (oldDep, newDep) {
      return newDep[0] is Success ||
          newDep[0] is Failure ||
          newDep[1] != oldDep[1];
    },
  );
}

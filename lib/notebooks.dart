import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/notebooks/notebooks_screen.dart';
import 'package:orditori/services.dart';

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
    return client.notebooksGet(apiKey: token);
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

          final notebook = v.body!;

          final savedDefinitions = notebook.entries
              .expand((element) => element.definitions)
              .map((e) => e.definitionId)
              .toSet();

          n.provideValueAsRef(savedDefinitions);

          return builder(null, (
            padding: padding,
            notebook: n.provideValueAsRef(notebook),
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

import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/services.dart';

import 'swagger_generated_code/orditori.swagger.dart';

Widget withNotebooks({
  required CTNode n,
  required String token,
  required Trigger<String> setToken,
  required Widget Function(Widget? child) builder,
}) {
  final load = n.trigger();

  final r = load.asyncHandler(() {
    return client.notebooksGet(apiKey: token);
  }, invoke: true);

  load.provide(VoidTrigger.token<NotebookR>());

  return CTBuilder(
    (n, context) {
      if (r is Loading || r is Pending) {
        return builder(
          const Center(child: CircularProgressIndicator()),
        );
      }

      if (r is Failure) {
        return builder(
          Text(r.failure().exception.toString()),
        );
      }

      if (r.success().value.body == null) {
        return builder(
          const Center(
            child: Text('Probably invalid token'),
          ),
        );
      }

      final notebook = r.success().value.body!;

      final savedDefinitions = notebook.entries
          .expand((element) => element.definitions)
          .map((e) => e.definitionId)
          .toSet();

      n.provideValueAsRef(notebook);
      n.provideValueAsRef(savedDefinitions);

      return builder(null);
    },
    dep: [r, token],
    when: (oldDep, newDep) {
      return newDep[0] is Success ||
          newDep[0] is Failure ||
          newDep[1] != oldDep[1];
    },
  );
}

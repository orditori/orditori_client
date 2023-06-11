import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import 'notebook_entries_list.dart';

class DefinitionsDateGroup {
  final String date;
  final List<NotebookEntryR> entries;

  DefinitionsDateGroup(this.date, this.entries);
}

typedef NotebooksContext = ({
  Token<Ref<EdgeInsets>> padding,
  Token<Ref<NotebookR>> notebook,
  Token<VoidTrigger> refreshNotebook,
  Token<Ref<Set<int>>> savedDefinitions,
});

class Notebooks extends CTWidget<NotebooksContext> {
  @override
  bool get static => true;

  const Notebooks({
    super.key,
    required super.context,
  });

  @override
  Widget build(CTNode n, NotebooksContext context) {
    final notebook = n.consume(context.notebook).subscribe();

    final g = notebook.entries.fold<List<DefinitionsDateGroup>>([], (acc, v) {
      final date = formatDate(DateTime.parse(v.addedDate));

      if (acc.isEmpty) {
        return [
          DefinitionsDateGroup(date, [v])
        ];
      }

      if (acc.last.date == date) {
        return [
          ...acc.take(acc.length - 1),
          DefinitionsDateGroup(date, [...acc.last.entries, v])
        ];
      }

      return [
        ...acc,
        DefinitionsDateGroup(date, [v])
      ];
    });

    final entries = g.reversed
        .expand((element) => element.entries.reversed)
        .where((element) => element.definitions.isNotEmpty)
        .toList();

    return NotebookEntriesList(
      context: (
        padding: context.padding,
        refreshNotebook: context.refreshNotebook,
      ),
      entries: entries,
      notebookId: notebook.id,
    );
  }
}

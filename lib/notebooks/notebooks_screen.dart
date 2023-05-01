import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import 'notebook_entries_list.dart';

class DefinitionsDateGroup {
  final String date;
  final List<NotebookEntryR> entries;

  DefinitionsDateGroup(this.date, this.entries);
}

class Notebooks extends CTWidget {
  @override
  bool get static => true;

  const Notebooks({super.key});

  @override
  Widget build(CTNode n, CTContext context) {
    final notebook = context.ref<NotebookR>().subscribe();

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
      entries: entries,
      notebookId: notebook.id,
    );
  }
}

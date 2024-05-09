import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import 'notebook_entries_list.dart';

typedef NotebooksContext = ({
  Token<Ref<EdgeInsets>> padding,
  Token<Ref<int>> notebookId,
  Token<Ref<PaginatedNotebookQueryResponseYear>> notebookYearGroups,
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
    final notebookYearGroups =
        n.consume(context.notebookYearGroups).subscribe();

    final notebookListItems = notebookYearGroups.items.expand((yearGroup) {
      final firstMonth = yearGroup.months.first;
      return [
        NotebookEntryListItemYearMonth(yearGroup.year, firstMonth.month),
        ...firstMonth.days.expand(
          (dayGroup) => dayGroup.entries.expand(
            (entry) => entry.definitions.map(
              (definition) => NotebookEntryListItemDCI(
                definition,
                DateTime.parse(entry.addedDate),
              ),
            ),
          ),
        ),
        ...yearGroup.months.skip(1).expand((monthGroup) => [
              NotebookEntryListItemYearMonth(null, monthGroup.month),
              ...monthGroup.days.expand(
                (dayGroup) => dayGroup.entries.expand(
                  (entry) => entry.definitions.map(
                    (definition) => NotebookEntryListItemDCI(
                      definition,
                      DateTime.parse(entry.addedDate),
                    ),
                  ),
                ),
              )
            ])
      ];
    });

    return NotebookEntriesList(context: (
      padding: context.padding,
      refreshNotebook: context.refreshNotebook,
    ), items: notebookListItems.toList());
  }
}

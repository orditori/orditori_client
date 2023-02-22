import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:orditori/search/search_screen.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'package:orditori/widgets/async_widget.dart';

import 'notebook_entries_list.dart';

class DefinitionsDateGroup {
  final String date;
  final List<NotebookEntryR> entries;

  DefinitionsDateGroup(this.date, this.entries);
}

class Notebooks extends StatelessWidget {
  const Notebooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = AsyncWidget.read<Response<NotebookR>>(context)!.body!;
    final g = r.entries!.fold<List<DefinitionsDateGroup>>([], (acc, v) {
      final date = formatDate(DateTime.parse(v.addedDate!));

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
        .where((element) => element.definitions?.isNotEmpty ?? false)
        .toList();

    SearchScreen.notebookId = r.id!;
    SearchScreen.notebookEntries = entries;

    final child = NotebookEntriesList(
      entries: entries,
      notebookId: r.id!,
    );

    return child;
  }
}

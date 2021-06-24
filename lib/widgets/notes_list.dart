import 'package:flutter/material.dart';
import 'package:orditori/domains/notebooks/state_container.dart';
import 'package:orditori/models/notebookentry.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/widgets/format.dart';
import 'package:orditori/widgets/word_tile.dart';

import 'date_tile.dart';

class DateGroup {
  late final String? date;
  late final List<NotebookEntry> entries;
}

class NotesList extends StatelessWidget {
  final ctrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    return context.subscribe<List<NotebookEntry>>(
      builder: (context, value, _) {
        final items = value.reversed.toList();

        final groupedByDate =
            items.fold<List<DateGroup>>([], (previousValue, element) {
          final k = dateFormat.format(DateTime.parse(element.addedDate));

          if (previousValue.isEmpty) {
            previousValue.add(DateGroup()
              ..date = k
              ..entries = [element]);
            return previousValue;
          }

          if (previousValue.last.date == k) {
            previousValue.last.entries.add(element);
            return previousValue;
          }

          previousValue.add(
            DateGroup()
              ..date = k
              ..entries = [element],
          );

          return previousValue;
        }).toList();

        return ListView.separated(
            controller: ctrl,
            reverse: true,
            itemCount: groupedByDate.length,
            separatorBuilder: (context, index) {
              return Container(height: 1, color: Colors.white.withAlpha(10));
            },
            itemBuilder: (context, index) {
              final g = groupedByDate[index];
              final entries = g.entries.reversed
                  .toList()
                  .where((e) => e.definitions.isNotEmpty)
                  .toList();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: DateTile(date: dateFormat.parse(g.date!)),
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (int i = 0; i < entries.length; i++) ...[
                              WordTile(
                                language: entries[i].definitions.first.language,
                                word: entries[i].definitions.first.word,
                                definition:
                                    entries[i].definitions.first.definition,
                                examples: entries[i]
                                    .definitions
                                    .first
                                    .examples
                                    .map((e) => e.string)
                                    .toList(),
                                onDelete: () async {
                                  context.mutation(DeleteNote(entries[i].id));
                                  Navigator.of(context).pop();
                                },
                              ),
                              if (i != entries.length - 1) Divider(),
                            ]
                          ]),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}

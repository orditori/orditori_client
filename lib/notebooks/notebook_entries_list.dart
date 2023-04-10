import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:intl/intl.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import 'date_tile.dart';
import 'definition_tile.dart';

String formatDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}

class NotebookEntriesList extends StatelessWidget {
  final int notebookId;
  final List<NotebookEntryR> entries;
  final Trigger refreshNotebook;

  const NotebookEntriesList({
    super.key,
    required this.entries,
    required this.notebookId,
    required this.refreshNotebook,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: AnimatedList(
        reverse: true,
        padding: const EdgeInsets.only(bottom: 20),
        initialItemCount: entries.length,
        itemBuilder: (context, index, _) {
          final item = entries[index];
          final nextItem =
              index == entries.length - 1 ? null : entries[index + 1];

          final date = formatDate(DateTime.parse(item.addedDate));

          final nextDate = formatDate(
            DateTime.parse((nextItem ?? item).addedDate),
          );

          Widget leading = const SizedBox(width: 40);

          if (nextDate != date || nextItem == null) {
            final ch = date.split(' ');
            leading = DateTile(month: ch[0], day: ch[1]);
          }

          final def = item.definitions.first;

          return NotebookEntryTile(
            def: def,
            entry: item,
            leading: leading,
            refreshNotebook: refreshNotebook,
          );
        },
      ),
    );
  }
}

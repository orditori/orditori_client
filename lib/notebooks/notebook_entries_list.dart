import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:intl/intl.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import 'date_tile.dart';
import 'definition_tile.dart';

String formatDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}

typedef NotebookEntriesListContext = ({
  Token<Ref<EdgeInsets>> padding,
  Token<VoidTrigger> refreshNotebook,
});

class NotebookEntriesList extends CTWidget<NotebookEntriesListContext> {
  final int notebookId;
  final List<NotebookEntryR> entries;

  const NotebookEntriesList({
    super.key,
    required super.context,
    required this.entries,
    required this.notebookId,
  });

  @override
  Widget build(CTNode n, NotebookEntriesListContext context) {
    final padding = n.consume(context.padding).subscribe();
    final refreshNotebook = n.consume(context.refreshNotebook);

    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.only(bottom: 20).copyWith(
        top: padding.top,
        left: padding.left,
        right: padding.right,
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) {
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
    );
  }
}

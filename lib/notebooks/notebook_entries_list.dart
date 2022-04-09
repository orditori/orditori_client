import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import 'date_tile.dart';
import 'definition_tile.dart';

String formatDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}

class NotebookEntriesList extends StatefulWidget {
  final int notebookId;
  final List<NotebookEntryR> entries;
  const NotebookEntriesList({
    Key? key,
    required this.entries,
    required this.notebookId,
  }) : super(key: key);

  @override
  State<NotebookEntriesList> createState() => NotebookEntriesListState();
}

class NotebookEntriesListState extends State<NotebookEntriesList> {
  List<NotebookEntryR> get entries => widget.entries;
  int get notebookId => widget.notebookId;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      reverse: true,
      padding: const EdgeInsets.only(bottom: 20),
      initialItemCount: widget.entries.length,
      itemBuilder: (context, index, _) {
        final item = widget.entries[index];
        final nextItem = index == widget.entries.length - 1
            ? null
            : widget.entries[index + 1];

        final date = formatDate(DateTime.parse(item.addedDate!));
        final nextDate =
            formatDate(DateTime.parse((nextItem ?? item).addedDate!));

        Widget leading = const SizedBox(width: 40);

        if (nextDate != date || nextItem == null) {
          final ch = date.split(' ');
          leading = DateTile(month: ch[0], day: ch[1]);
        }

        final def = item.definitions!.first;

        return DefinitionTile(def: def, leading: leading);
      },
    );
  }
}

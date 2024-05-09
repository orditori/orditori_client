import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:intl/intl.dart';
import 'package:orditori/notebooks/date_tile.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'definition_tile.dart';

String formatDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}

typedef NotebookEntriesListContext = ({
  Token<Ref<EdgeInsets>> padding,
  Token<VoidTrigger> refreshNotebook,
});

sealed class NotebookEntryListItem {}

class NotebookEntryListItemDCI extends NotebookEntryListItem {
  DefinitionContentItemR definition;
  DateTime addedDate;

  NotebookEntryListItemDCI(this.definition, this.addedDate);
}

class NotebookEntryListItemYearMonth extends NotebookEntryListItem {
  final int? year;
  final int month;

  NotebookEntryListItemYearMonth(this.year, this.month);
}

class NotebookEntriesList extends CTWidget<NotebookEntriesListContext> {
  final List<NotebookEntryListItem> items;

  const NotebookEntriesList({
    super.key,
    required super.context,
    required this.items,
  });

  Widget makeDefinitionWidget(
    DefinitionContentItemR definitionItem,
    DateTime addedDate,
    Consumed<VoidTrigger> refreshNotebook,
  ) {
    final Widget leading = DateTile(
        month: DateFormat('MMM').format(addedDate),
        day: DateFormat('dd').format(addedDate));

    return DCITile(
      def: definitionItem,
      leading: leading,
      refreshNotebook: refreshNotebook,
    );
  }

  @override
  Widget build(CTNode n, NotebookEntriesListContext context) {
    final padding = n.consume(context.padding).subscribe();
    final refreshNotebook = n.consume(context.refreshNotebook);

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20).copyWith(
        top: padding.top,
        left: padding.left,
        right: padding.right,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return switch (item) {
          NotebookEntryListItemDCI(
            definition: var definition,
            addedDate: var addedDate
          ) =>
            makeDefinitionWidget(definition, addedDate, refreshNotebook),
          NotebookEntryListItemYearMonth(year: var year, month: var month) =>
            Column(
              children: [
                if (year != null) Text(year.toString()),
                Text(
                  DateFormat('MMM').format(DateTime(0, month)).toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            )
        };
      },
    );
  }
}

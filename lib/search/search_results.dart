import 'package:flutter/material.dart';
import 'package:orditori/framework.dart';

import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import 'definition_tile.dart';

class SearchResults extends StatelessWidget {
  final String? error;
  final bool hasResult;
  final Receive<TextEditingValue> query;
  final Set<String> definitionsSet;
  final List<DefinitionsWithSource> items;
  final void Function(Definition def, int sourceId, String link) onAdd;

  const SearchResults({
    Key? key,
    this.error,
    this.hasResult = false,
    required this.query,
    required this.items,
    required this.onAdd,
    this.definitionsSet = const {},
  }) : super(key: key);

  Iterable<Widget> getItems(BuildContext context) sync* {
    int outerCursor = 0;
    int innerCursor = 0;

    while (true) {
      if (outerCursor >= items.length) return;

      final group = items[outerCursor];

      if (innerCursor == 0 && group.definitions!.isNotEmpty) {
        yield Padding(
          padding: const EdgeInsets.all(8.0).copyWith(
            left: 16,
            top: outerCursor != 0 ? 16 : 8,
          ),
          child: Text(
            group.definitionSource!.name!,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      }

      if (innerCursor >= group.definitions!.length) {
        innerCursor = 0;
        outerCursor++;
        continue;
      }

      final def = group.definitions![innerCursor];

      yield DefinitionTile(
        def: def,
        isSaved: definitionsSet.contains(def.definition),
        onBookmarkPressed: () {
          if (!definitionsSet.contains(def.definition)) {
            onAdd(
              def,
              group.definitionSource!.id!,
              def.sourceLink!,
            );
          }
        },
      );

      innerCursor++;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Center(child: Text(error!));
    }

    if (hasResult && items.every((element) => element.definitions!.isEmpty)) {
      return Center(
        child: Text('Nothing found for "${query.read().text}"'),
      );
    }

    final children = getItems(context).toList();

    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import 'definition_tile.dart';

class DefinitionWithSource {
  final DefinitionR def;
  final DefinitionSource source;

  const DefinitionWithSource({
    required this.def,
    required this.source,
  });
}

class SearchResults extends CTWidget {
  final String? error;
  final bool hasResult;
  final List<DefinitionsWithSource> items;
  final String query;
  final Trigger refreshNotebook;

  const SearchResults({
    super.key,
    this.error,
    this.hasResult = false,
    required this.query,
    required this.items,
    required this.refreshNotebook,
  });

  Iterable<Widget> getItems(BuildContext context) sync* {
    int outerCursor = 0;
    int innerCursor = 0;

    while (true) {
      if (outerCursor >= items.length) return;

      final group = items[outerCursor];

      if (innerCursor == 0 && group.definitions.isNotEmpty) {
        yield Padding(
          padding: const EdgeInsets.all(8.0).copyWith(
            left: 16,
            top: outerCursor != 0 ? 16 : 8,
          ),
          child: Text(
            group.definitionSource.name,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      }

      if (innerCursor >= group.definitions.length) {
        innerCursor = 0;
        outerCursor++;
        continue;
      }

      final definition = group.definitions[innerCursor];

      yield DefinitionTile(
        definition: definition,
        refreshNotebook: refreshNotebook,
        source: group.definitionSource,
      );

      innerCursor++;
    }
  }

  @override
  Widget build(CTNode n) {
    if (error != null) {
      return Center(child: Text(error!));
    }

    if (hasResult && items.every((element) => element.definitions.isEmpty)) {
      return Center(
        child: Text('Nothing found for "$query"'),
      );
    }

    final children = getItems(n.context).toList();

    final paddingRef = Ref.consume<EdgeInsets>(n);
    final padding = n.subscribeToRef(paddingRef.just().value);

    return ListView.builder(
      padding: padding,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }
}

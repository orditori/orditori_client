import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/search/search_screen.dart';

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

typedef SearchResultsContext = ({
  Token<Ref<EdgeInsets>> padding,
  Token<Ref<NotebookR>> notebook,
  Token<Ref<Set<int>>> savedDefinitions,
  Token<VoidTrigger> refreshNotebook,
});

class SearchResults extends CTWidget<SearchResultsContext> {
  final String? error;
  final bool hasResult;
  final List<DefinitionsWithSource> items;
  final String query;
  final ScrollController? scrollController;

  const SearchResults({
    super.key,
    required super.context,
    required this.query,
    required this.items,
    this.error,
    this.hasResult = false,
    this.scrollController,
  });

  Iterable<Widget> getItems(
    SearchResultsContext context,
    Consumed<VoidTrigger> refreshNotebook,
    TextStyle definitionSourceNameStyle,
  ) sync* {
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
            style: definitionSourceNameStyle,
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
        context: (
          notebook: context.notebook,
          savedDefinitions: context.savedDefinitions,
        ),
      );

      innerCursor++;
    }
  }

  @override
  Widget build(CTNode n, SearchResultsContext context) {
    if (error != null) {
      return Center(child: Text(error!));
    }

    if (hasResult && items.every((element) => element.definitions.isEmpty)) {
      return Center(
        child: Text('Nothing found for "$query"'),
      );
    }

    final definitionSourceNameStyle = Theme.of(n.context)
        .textTheme
        .labelSmall!
        .copyWith(fontSize: 18, fontWeight: FontWeight.bold);

    final padding = n.consume(context.padding).subscribe();
    final refreshNotbeook = n.consume(context.refreshNotebook);

    final children = getItems(
      context,
      refreshNotbeook,
      definitionSourceNameStyle,
    ).toList();
    final selectionRef = n.ref(() => '');

    void searchFromSelection(SelectableRegionState state) {
      showModalBottomSheet(
        context: n.context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.85,
            builder: (_, controller) {
              return SearchScreen(
                onExit: null,
                scrollController: controller,
                initialQuery: selectionRef.value,
                autofocus: false,
                context: context,
              );
            },
          );
        },
      );
    }

    return SelectionArea(
      onSelectionChanged: (value) {
        selectionRef.value = value?.plainText ?? '';
      },
      contextMenuBuilder: (context, state) {
        return AdaptiveTextSelectionToolbar.buttonItems(
          anchors: state.contextMenuAnchors,
          buttonItems: [
            ContextMenuButtonItem(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: selectionRef.value));
                state.hideToolbar();
              },
              label: 'Copy',
            ),
            ContextMenuButtonItem(
              onPressed: () {
                searchFromSelection(state);
              },
              label: 'Search',
            ),
          ],
        );
      },
      child: ListView.builder(
        padding: padding,
        itemCount: children.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          return children[index];
        },
      ),
    );
  }
}
